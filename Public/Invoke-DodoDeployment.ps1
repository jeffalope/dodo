function Invoke-DodoDeployment {
  <#
      .SYNOPSIS
          Executes tsql script(s) against sql server(s)

      .DESCRIPTION
          The currently selected file(s)/folder(s) in windows explorer will be run against a server or
          group of servers configured in a config file/dynamic function

      .EXAMPLE
          Invoke-DodoDeployment;

          Deploys the script(s) the arguments
          
      .FUNCTIONALITY
          SQL
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
      [string[]]$FileList,
      [string]$Environment,
      [string]$Group,
      [bool]$SkipConfirmation
  )
  try {

    $successForegroundColor = "White";
    $failureForegroundColor = "White";
    $successBackgroundColor = "DarkGreen";
    $failureBackgroundColor = "DarkRed";
    
    
    if ($Environment.Length -eq 0)
    {
      $environments = Get-DatabaseInstances | Select-Object -Property EnvironmentName -Unique | Sort-Object -Property EnvironmentName | ForEach-Object {"$($_.EnvironmentName)"};
      $Environment = Get-UserInputFromList -ValueList $environments;
    }

    if ($Group.Length -eq 0)
    {
      $groups = Get-DatabaseInstances | Select-Object -Property GroupName -Unique | Sort-Object -Property GroupName | ForEach-Object {"$($_.GroupName)"};
      $Group = Get-UserInputFromList -ValueList $groups;
    }

    $instances = Get-DatabaseInstances -EnvironmentNameFilter $Environment -GroupNameFilter $Group;

    if($instances.Count -eq 0)
    {
      Write-Host "No instances matched the filters" -ForegroundColor $failureForegroundColor -BackgroundColor $failureBackgroundColor;
    }
    else 
    {
      Write-ListOutput -Message "Preparing to deploy the following file(s)" -ValueList $filelist;

      $instanceList = $instances | Select-Object -Property DisplayName -Unique | Sort-Object -Property DisplayName | ForEach-Object {"$($_.DisplayName)"};
      Write-ListOutput -Message "to the following server(s)" -ValueList $instanceList;

      if (-not $SkipConfirmation)
      {
        $msg = 'Do you want to proceed? (y/n)'
        do {
            $response = Read-Host -Prompt $msg
            if ($response -eq 'n') {
              exit;
            }
        } until ($response -eq 'y')
      }
            
      foreach($instance in $instances)
      {
        $contextDisplayName = $instance.DisplayName;
        if($instance.PromptForSQLAuth)
        {
          $Credential = Get-Credential -Message "Provide the valid SQL Auth credentials for $($instance.DisplayName)";
          Write-Host "";
        }

        Write-Host "Executing on $($instance.DisplayName): " -NoNewline;
        foreach($file in $filelist)
        {
          $contextFileName = $file;
          if ($instance.ConnectionString -ne "")
          {
            $output = Invoke-DodoSqlcmd2 -SQLConnection $instance.ConnectionString -InputFile $file;
          }
          else
          {
            $output = Invoke-DodoSqlcmd2 -ServerInstance $instance.InstanceName -Database $instance.DatabaseName -InputFile $file -Credential $Credential;
          }
          $contextFileName = "";
        }
        Write-Host "Complete" -ForegroundColor $successForegroundColor -BackgroundColor $successBackgroundColor;
        $contextDisplayName = "";
      }
      Write-Host "";
    
      Write-ListOutput -Message "The following file(s) were successfully deployed" -ValueList $filelist;
    }

    #Write-Host -NoNewLine 'Press any key to continue...';
    #$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    
  }
  catch
  {
    Write-Host "";
    Write-Host $_.Exception.Message -ForegroundColor $failureForegroundColor -BackgroundColor $failureBackgroundColor;
    if ($contextDisplayName -ne "")
    {
      Write-Host "DisplayName: $contextDisplayName" -ForegroundColor $failureForegroundColor -BackgroundColor $failureBackgroundColor;
    }
    if ($contextFileName -ne "")
    {
      Write-Host "FileName: $contextFileName" -ForegroundColor $failureForegroundColor -BackgroundColor $failureBackgroundColor;
    }
  }
} 

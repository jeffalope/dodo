function Get-DatabaseInstances {
  <#
      .SYNOPSIS
          Provides a list of instances

      .DESCRIPTION
          A structured list of database instances will be returned that contains the following attributes
            InstanceName - FQDN/IPAddress with port of the instance
            DisplayName - Short/Display name that will be used in messaging
            DatabaseName - Database name that will be connected to
            GroupName - Used to group servers
            EnvironmentName - Used to group servers by environment
            PromptForSQLAuth - Boolean value to indicate whether Username/Password will need to be provided at runtime
            ConnectionString - Optional but if populated will be used when connecting to the Instance

      .PARAMETER EnvironmentNameFilter
          Parameter used to filter the list of instances returned

      .PARAMETER GroupNameFilter
          Parameter used to filter the list of instances returned
      
      .EXAMPLE
          Get-DatabaseInstances;

          Gets all database instances

      .EXAMPLE
          Get-DatabaseInstances -EnvironmentNameFilter "Dev";

          Gets all database instances that have an EnvironmentName that contains "Dev"

      .EXAMPLE
          Get-DatabaseInstances -GroupNameFilter "WeatherData";

          Gets all database instances that have a GroupName that contains "WeatherData"
                
      .FUNCTIONALITY
          SQL
  #>
  [CmdletBinding()]
    param(
      [Parameter(Mandatory = $false)]
      [string]$EnvironmentNameFilter,
      [Parameter(Mandatory = $false)]
      [string]$GroupNameFilter
    )

  try {
    
    Write-Verbose "EnvironmentNameFilter: $($EnvironmentNameFilter)";
    
    $databaselist = New-Object System.Collections.ArrayList;

    $dblist = @(
    ('localhost', 'WeatherData001', 'WeatherData001', 'WeatherData', 'Dev', $false, ''),
    ('localhost', 'WeatherData002', 'WeatherData002', 'WeatherData', 'Dev', $false, ''),
    ('localhost', 'WeatherData003', 'WeatherData003', 'WeatherData', 'Dev', $false, ''),
    ('localhost', 'WeatherData004', 'WeatherData004', 'WeatherData', 'Dev', $false, ''),
    ('localhost', 'SampleData', 'SampleData', 'SampleData', 'Dev', $false, ''),
    ('localhost', 'localhost_master', 'master', 'master', 'Dev', $false, 'Server=localhost;Database=master;Trusted_Connection=True;');
    )

    foreach ($db in $dblist)
    {
      $database = New-Object System.Object;

      $database | Add-Member -type NoteProperty -name InstanceName -Value $db[0];
      $database | Add-Member -type NoteProperty -name DisplayName -Value $db[1];
      $database | Add-Member -type NoteProperty -name DatabaseName -Value $db[2];
      $database | Add-Member -type NoteProperty -name GroupName -Value $db[3];
      $database | Add-Member -type NoteProperty -name EnvironmentName -Value $db[4];
      $database | Add-Member -type NoteProperty -name PromptForSQLAuth -Value $db[5];
      $database | Add-Member -type NoteProperty -name ConnectionString -Value $db[6];

      $databaselist.Add($database) | Out-Null;
    }

    if($EnvironmentNameFilter -ne "")
    {
      $databaselist = $databaselist | Where-Object {$_.EnvironmentName -contains $EnvironmentNameFilter};
    }

    if($GroupNameFilter -ne "")
    {
      $databaselist = $databaselist | Where-Object {$_.GroupName -contains $GroupNameFilter};
    }

    return $databaselist;
  }
  catch
  {
    throw $_;
  }
} 

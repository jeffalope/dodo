function Get-UserInputFromList {
  <#
      .SYNOPSIS
          Takes a list of values and prompts the user to choose one

      .DESCRIPTION
          A list of values will be provided as an input and then the user will be prompted to choose one
          of the values.

      .PARAMETER ValueList
          An array of values to use as the list to prompt the user
      
      .EXAMPLE
          $List = @('A', 'B', 'C');

          $choice = Get-UserInputFromList -ValueList $List;

          Prompt a user to chose A or B or C

      .FUNCTIONALITY
          SQL
  #>
  [CmdletBinding()]
    param(
      [Parameter(Mandatory = $true)]
      [string[]]$ValueList
    )

  try {
    
    Write-Verbose "ValueList: ";
    foreach ($value in $ValueList)
    {
      Write-Verbose $value;
    }
    
    $choices = New-Object System.Collections.ArrayList;

    $index = 0;

    foreach ($value in $ValueList)
    {
      $v = New-Object System.Object;

      $v | Add-Member -type NoteProperty -name Key -Value $index;
      $v | Add-Member -type NoteProperty -name Value -Value $value;
      
      $choices.Add($v) | Out-Null;
      $index++;
    }
    
    $maxRetries = 3;
    $choice = "";

    while ($maxRetries -gt 0)
    {
      Write-Host "Choose an option from the list: ";
      foreach ($c in $choices | Sort-Object -Property Key)
      {
        Write-Host "`t($($c.Key)) $($c.Value)";
      }
      
      $choiceKey = Read-Host;

      if ($choiceKey -ge 0 -and $choiceKey -lt $index)
      {
        $maxRetries = 0;
        $choice = $($choices | Where-Object {$_.Key -eq $choiceKey} | Select-Object -Property Value).Value;
      }
      else {
        Write-Host "Option was not a valid option";
        $maxRetries--;
      }
      Write-Host "";
    }
    return $choice;
  }
  catch
  {
    throw $_;
  }
} 

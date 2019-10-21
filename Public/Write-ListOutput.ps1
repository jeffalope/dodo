function Write-ListOutput {
  <#
      .SYNOPSIS
          Takes a list of values and displays them

      .DESCRIPTION
          A header string and a list of values will be provided as an input and then displayed
          of the values.

      .PARAMETER Message
          Header message to show above the list items

      .PARAMETER ValueList
          Array of values to be displayed
      
      .EXAMPLE
          $List = @('A', 'B', 'C');

          Write-ListOutput -Message "List of Letters" -ValueList $List;

      .FUNCTIONALITY
          SQL
  #>
  [CmdletBinding()]
    param(
      [Parameter(Mandatory = $true)]
      [string]$Message,
      [Parameter(Mandatory = $true)]
      [string[]]$ValueList
    )

  try {
    
    Write-Host "$($Message): ";
    foreach ($value in $ValueList)
    {
      Write-Host "`t$value";
    }
    Write-Host "";
  }
  catch
  {
    throw $_;
  }
} 

function New-DodoSendToShortcut {
  <#
      .SYNOPSIS
          Creates shortcut that is added to the "Send To" menu when right clicking on a file/folder

      .DESCRIPTION
          New shortcuts will be created in the "Send To" menu so that the additional option will be displayed
          in the list when right clicking on a file/folder.  

      .EXAMPLE
          New-DodoSendToShortcut;

          Creates the shortcut
                
      .FUNCTIONALITY
          SQL
  #>
  [CmdletBinding()]
    param()

  try {
    $sendToPath = [Environment]::GetFolderPath("SendTo");
    Write-Verbose "sendToPath: $($sendToPath)";
    
    $sendToPath = [Environment]::GetFolderPath("SendTo");
    $dodopath = $sendToPath + "\" + "dodo.lnk"

    if (Test-Path $dodopath)
    {
        Write-Host "Dodo shortcut already exists, attempting to delete it... " -NoNewline
        Remove-Item $dodopath;
        write-host "success"
    }

    $targetpath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($dodopath);
    $Shortcut.TargetPath = $targetpath
    $Shortcut.Arguments = "-file ""C:\Users\jeffn\OneDrive\Documents\WindowsPowerShell\Modules\dodo\Scripts\DodoWrapper.ps1"""
    $Shortcut.Save()


    Write-Verbose "Shortcut was successfully created";
  }
  catch
  {
    throw $_;
  }
} 

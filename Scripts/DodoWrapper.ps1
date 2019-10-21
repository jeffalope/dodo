$filelist = New-Object System.Collections.ArrayList;

foreach ($f in $args)
{
    if(Test-Path $f -PathType Container)
    {
        $children = Get-ChildItem -Path $f;
        foreach ($c in $children)
        {
            $filelist.Add($c) | Out-Null;
        }
    }
    else {
        $filelist.Add($f) | Out-Null;
    }
}
Invoke-DodoDeployment -FileList $filelist;
#requires -module ChangeLogManagement

#get ISO8601 date
$dt = Get-Date -format "yyyy-MM-dd HH:mm:ss"

$moduleName = Split-Path -path $PSScriptRoot -Leaf

#get changelog data
$change = Get-ChangelogData -Path .\ChangeLog.md

#get latest release
$modVersion = $change.LastVersion

#get previous releases
[regex]$rx = "(?<=\[)\d\.\d\.\d"
$releases = $change.footer.split("`n") | Select-Object -skip 1
$prev = $rx.match($releases[1]).value

$link = "[$modVersion]: https://github.com/jdhitsolutions/$moduleName/compare/v$prev...v$modVersion"

#$change.footer.split("`n").where({$_ -match "\[$modVersion\]"})
if ($modVersion -as [version]) {
    $md = [System.Collections.Generic.list[String]]::new()
    $md.add($change.header.split("`n")[0])
    $md.add("## v[$modVersion] - $dt`n")
    $md.add($change.ReleaseNotes)
    $md.Add("`n$link")
    $md | Out-File .\scratch-change.md
    code .\scratch-change.md
}
else {
    Write-Warning "Changelog does not follow the newer format."
}

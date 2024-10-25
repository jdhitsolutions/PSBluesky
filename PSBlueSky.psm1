
#region Main

Get-ChildItem -path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName}

#endregion



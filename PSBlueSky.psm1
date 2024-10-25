#region Main

Get-ChildItem -path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName}

#define a module scoped variable
$PDSHOST = 'https://bsky.social'

#endregion

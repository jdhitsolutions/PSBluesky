#region Main

Get-ChildItem -path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName}

#define a module scoped variable
$PDSHOST = 'https://bsky.social'

$ModuleVersion = (Import-PowerShellDataFile -Path $PSScriptRoot\PSBlueSky.psd1).ModuleVersion
#write-host "importing module version $ModuleVersion" -ForegroundColor Green

#register an event to remove the background session runspace
#when the module is removed
$OnRemoveScript = {
    #only run this code if the variable is defined
    if ($script:PSCmd) {
        $script:PSCmd.Runspace.Close()
        $script:PSCmd.Runspace.Dispose()
    }
}

$ExecutionContext.SessionState.Module.OnRemove += $OnRemoveScript

#endregion

#region type updates

Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName UserName -Value handle -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName AccessToken -Value AccessJwt -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName RefreshToken -Value RefreshJwt -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Date } -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptMethod -MemberName Refresh -Value {Update-BskySession -RefreshToken $this.RefreshJwt} -Force

#endregion
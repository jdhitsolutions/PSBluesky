#region Main

Get-ChildItem -path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName}

#define module scoped variables
$PDSHOST = 'https://bsky.social'
<#
initialize a caching hashtable for post texts.
The key will be an AT value like at://did:plc:ohgsqpfsbocaaxusxqlgfvd7/app.bsky.feed.post/3larqyjbyzl2a
and the value will the text of the post
#>
$PostCache = @{}

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
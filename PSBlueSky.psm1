#region load string data
# used for culture debugging
# write-host "Importing with culture $(Get-Culture)" -ForeGroundColor yellow

if ((Get-Culture).Name -match '\w+') {
    #write-host "Using culture $(Get-Culture)" -ForegroundColor yellow
    Import-LocalizedData -BindingVariable strings
}
else {
    #force using En-US if no culture found, which might happen on non-Windows systems.
    #write-host "Loading $PSScriptRoot/en-us/PSWorkItem.psd1" -ForegroundColor yellow
    Import-LocalizedData -BindingVariable strings -FileName PSBluesky.psd1 -BaseDirectory $PSScriptRoot/en-us
}

#endregion
#region Main

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName }

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
Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptMethod -MemberName Refresh -Value { Update-BskySession -RefreshToken $this.RefreshJwt } -Force

Update-TypeData -TypeName 'PSBlueskySearchResult' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
Update-TypeData -TypeName 'PSBlueskyProfile' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
Update-TypeData -TypeName 'PSBlueskyFollowProfile' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
#endregion

#region verbose command highlighting

<#
a hash table to store ANSI escape sequences for different commands
used in verbose output with the private _verbose helper function
#>
$VerboseANSI = @{
    'Add-BskyImage'        = '[1;38;5;122m'
    'Find-BskyUser'        = '[1;38;5;111m'
    'Get-BskyFeed'         = '[1;96m'
    'Get-BskyFollowers'    = '[1;38;5;10m'
    'Get-BskyFollowing'    = '[1;38;5;208m'
    'New-BskyPost'         = '[1;38;5;159m'
    'Get-BskyNotification' = '[1;38;5;195m'
    'Get-BskyProfile'      = '[1;38;5;214m'
    'Start-BskySession'    = '[1;38;5;228m'
    'Get-BskySession'      = '[1;38;5;197m'
    Default                = '[1;38;5;51m'
}

#endregion
#region load string data
# used for culture debugging
#write-host "Importing with culture $(Get-Culture)" -ForeGroundColor yellow

if ((Get-Culture).Name -match '\w+' -AND (Test-Path "$PSScriptRoot/$((Get-Culture).Name)/PSBluesky.psd1")) {
    #write-host "Loading $PSScriptRoot\$((Get-Culture).Name)\PSBluesky.psd1" -ForegroundColor yellow
    Import-LocalizedData -BindingVariable strings
}
else {
    #force using En-US if no culture found, which might happen on non-Windows systems.
    #write-host "Loading $PSScriptRoot\en-us\PSBluesky.psd1" -ForegroundColor yellow
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
# 21 Nov 2024 - making this a global variable which will persist
# between module reloads. Thanks to @ShaunLawrie for the suggestion
if ($null -eq $global:BskyPostCache) {
    $global:BskyPostCache = @{}
}

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
    #clean up type data to avoid errors on re-importing
    'PSBlueskySession', 'PSBlueskySearchResult',
    'PSBlueskyProfile', 'PSBlueskyFollowProfile',
    'PSBlueskyFeedItem', 'PSBlueskyTimelinePost' | Remove-TypeData
}

$ExecutionContext.SessionState.Module.OnRemove += $OnRemoveScript

#endregion

#region type updates

<#
10 Jan 2025 - moved these to the types.ps1xml file
Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName UserName -Value handle -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName AccessToken -Value AccessJwt -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName RefreshToken -Value RefreshJwt -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Date } -Force
Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptMethod -MemberName Refresh -Value { Update-BskySession -RefreshToken $this.RefreshJwt } -Force
Update-TypeData -TypeName 'PSBlueskySearchResult' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
Update-TypeData -TypeName 'PSBlueskyProfile' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
Update-TypeData -TypeName 'PSBlueskyFollowProfile' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Created } -Force
#>

#endregion

#region verbose command highlighting
# 10 Jan 2025 - moved this to the preferences file
<#
a hash table to store ANSI escape sequences for different commands
used in verbose output with the private _verbose helper function
#>
<#
$VerboseANSI = @{
    'Add-BskyImage'        = "`e[1m;38;5;122m'
    'Find-BskyUser'        = "`e[1m;38;5;111m'
    'Get-BskyFeed'         = "`e[1m;96m'
    'Get-BskyFollowers'    = "`e[1m;38;5;10m'
    'Get-BskyFollowing'    = "`e[1m;38;5;208m'
    'New-BskyPost'         = "`e[1m;38;5;159m'
    'Get-BskyNotification' = "`e[1m;38;5;195m'
    'Get-BskyProfile'      = "`e[1m;38;5;214m'
    'Start-BskySession'    = "`e[1m;38;5;228m'
    'Get-BskySession'      = "`e[1m;38;5;197m'
    DefaultCommand         = "`e[1m;38;5;51m'
} #>

#endregion

#region preferences

$prefPath = Join-Path -Path $HOME -ChildPath '.psbluesky-preferences.json'

If (Test-Path -Path $prefPath) {
    $bskyPreferences = [ordered]@{}
    $in = Get-Content -Path $prefPath | ConvertFrom-Json
    $in.PSObject.properties | ForEach-Object {
        $bskyPreferences[$_.Name] = $_.Value
    }
}
else {
    #Default preferences
    $bskyPreferences = [ordered]@{
        Username               = "`e[4;38;5;190m"
        ProfileDescription     = "`e[3;96m"
        Message                = "`e[3;93m"
        BlockedList            = "`e[4;92m"
        IsRepost               = "`e[36m"
        LikedLow               = "`e[38;5;48m"
        LikedMedium            = "`e[38;5;214m"
        LikedHigh              = "`e[38;5;105m"
        LikedHighest           = "`e[38;5;201m"
        InfoAlias              = "`e[3;38;5;220m"
        ActiveSession          = "`e[92m"
        InActiveSession        = "`e[91m"
        'Add-BskyImage'        = "`e[1;38;5;122m"
        'Find-BskyUser'        = "`e[1;38;5;111m"
        'Get-BskyFeed'         = "`e[1;96m"
        'Get-BskyBlockedList'  = "`e[1;38;5;165m"
        'Get-BskyBlockedUser'  = "`e[1;38;5;168m"
        'Get-BskyFollowers'    = "`e[1;38;5;182m"
        'Get-BskyFollowing'    = "`e[1;38;5;208m"
        'Get-BskyLiked'        = "`e[1;38;5;201m"
        'Get-BskyNotification' = "`e[1;38;5;195m"
        'Get-BskyProfile'      = "`e[1;38;5;214m"
        'Get-BskySession'      = "`e[1;38;5;197m"
        'New-BskyFollow'       = "`e[1;38;5;147m"
        'New-BskyPost'         = "`e[1;38;5;159m"
        'Publish-BskyPost'     = "`e[1;38;5;180m"
        'Remove-BskyFollow'    = "`e[1;95m"
        'Start-BskySession'    = "`e[1;38;5;228m"
        DefaultCommand         = "`e[1;38;5;51m"
    }
}

# Future Changes
# for future updates to preferences after version 2.3.0
# test if the preference exists, if not, add it

#endregion

#Export the variable as a global variable, otherwise the
#formatting files can't access it. This must be done with
##Export-ModuleMember due to a long time bug in PowerShell

#Need to export aliases here because I am exporting the variable
$AliasesToExport      = @(
    'skeet',
    'Refresh-BskySession',
    'Repost-BskyPost',
    'bshelp',
    'bsliked',
    'bsn',
    'bsp',
    'bsfeed',
    'bsfollow',
    'bsfollower',
    'bst',
    'bsu',
    'bss',
    'bsblock',
    'bsblocklist',
    'Follow-BskyUser',
    'Unfollow-BskyUser'
)
Export-ModuleMember -Variable bskyPreferences -Alias $AliasesToExport

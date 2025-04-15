#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.6.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c)2024-2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky AT Proto API. You can post and upload images from a PowerShell prompt, as well as get your timeline, feed, followers, and more. Run Open-BskyHelp after installation to launch a PDF guide. This module is written for PowerShell 7 and uses features like $PSStyle.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-BskyImage',
        'Block-BskyUser',
        'Find-BskyUser',
        'Find-BskyPost',
        'Get-BskyAccountDID',
        'Get-BskyBlockedList'
        'Get-BskyBlockedUser',
        'Get-BskyFeed',
        'Get-BskyFollowers',
        'Get-BskyFollowing',
        'Get-BskyLiked'
        'Get-BskyNotification'
        'Get-BskyProfile',
        'Get-BskySession',
        'Get-BskyStarterPack',
        'Get-BskyStarterPackList',
        'Get-BskyModuleInfo',
        'Get-BskyTimeline',
        'New-BskyFollow',
        'New-BskyPost',
        'Open-BskyHelp',
        'Publish-BskyPost',
        'Remove-BskyFollow',
        'Start-BskySession'
        'Update-BskySession',
        'Get-BskyPreference',
        'Set-BskyPreference',
        'Export-BskyPreference',
        'Remove-BskyPreferenceFile',
        'Enable-BskyLogging',
        'Disable-BskyLogging',
        'Get-BskyLogging',
        'Remove-BskyLogging',
        'Set-BskyLogging',
        'Unblock-BskyUser'
    )
    TypesToProcess       = @(
        'types/PSBlueSky.types.ps1xml'
    )
    FormatsToProcess     = @(
        'formats\PSBlueSkyTimelinePost.format.ps1xml',
        'formats\PSBlueskyBlockedUser.format.ps1xml',
        'formats\PSBlueskyBlockedList.format.ps1xml',
        'formats\PSBlueskyProfile.format.ps1xml',
        'formats\PSBlueskyFollower.format.ps1xml',
        'formats\PSBlueskyFeed.format.ps1xml',
        'formats\PSBlueskyLiked.format.ps1xml',
        'formats\PSBlueskySession.format.ps1xml',
        'formats\PSBlueskyNotification.format.ps1xml',
        'formats\PSBlueskySearchResult.format.ps1xml',
        'formats\PSBlueskyStarterPack.format.ps1xml',
        'formats\PSBlueskyStarterPackList.format.ps1xml',
        'formats\PSBlueskyModuleInfo.format.ps1xml'
    )
    CmdletsToExport      = ''
    VariablesToExport    = @('bskyPreferences','PDSHost')
    AliasesToExport      = @(
        'skeet',
        'Refresh-BskySession',
        'Repost-BskyPost',
        'bshelp',
        'bsliked',
        'bsn',
        'bsp',
        'bsf',
        'fbp'
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
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'atprotocol','atproto')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = ''
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}

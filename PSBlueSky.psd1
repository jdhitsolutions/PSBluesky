#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.3.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c)2024-2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt. This module is written for PowerShell 7 and uses features like $PSStyle.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-BskyImage',
        'Find-BskyUser',
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
        'Remove-BskyPreferenceFile'
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
        'formats\PSBlueskyModuleInfo.format.ps1xml'
    )
    CmdletsToExport      = ''
    VariablesToExport    = 'bskyPreferences'
    AliasesToExport      = @(
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
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'adprotocol')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [2.3.0] - 2025-01-13

### Added

- Added commands `New-BskyFollow` and `Remove-BskyFollow`, with aliases `Follow-BskyUser` and `Unfollow-BskyUser` to handle following and un-following Bluesky user accounts. [[Issue #32](https://github.com/jdhitsolutions/PSBluesky/issues/32)]
- Created a user-configurable preferences variable, `$bskyPreferences` and related commands: `Get-BskyPreference`, `Set-BskyPreference`, `Export-BskyPreference`, and `Remove-BskyPreferenceFile`. The preference variable is exported so that the formatting files can use it, but should be managed with the related functions. [[Issue #31](https://github.com/jdhitsolutions/PSBluesky/issues/31)]
- Added alias `bsliked` for `Get-BskyLiked`.

### Changed

- Updated verbose helper function to use the new formatting preferences.
- Updated formatting files to use the new preference variable.
- Moved all type extensions defined in the module file using `Update-TypeData` to the external types.ps1xml file.
- Updated `README.md`.
- Updated help documentation.
- Updated module to remove additional types on module removal.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}

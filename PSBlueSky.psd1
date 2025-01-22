#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.4.0'
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
            ReleaseNotes               = @'
## [2.4.0] - 2025-01-22

### Added

- Added property `DID` to follower objects.
- Added a script method called `CreateHeader` to the Bluesky session object (`bskySession`). This header can be used with the Bluesky API for custom testing or development.
- Added commands `Block-BskyUser` and `Unblock-BskyUser`.
- Added properties `Viewer` and `Labels` to profile objects including blocked user profiles.
- Added a feature to create a log of API usage. Added properties `bskyLoggingEnabled` and `bskyLogFile` to the PSBluesky session object. The log is a JSON file of structured data. Logging is disabled by default on module import. Commands `Disable-BskyLogging`,`Enable-BskyLogging`,`Get-BskyLogging`,`Set-BskyLogging` and `Remove-BskyLogging` have been added to manage this feature.
- Added properties `isRead`, `Labels`, and `SeenAt` to`PSBlueSkyNotification` object. [[Issue #34](https://github.com/jdhitsolutions/PSBluesky/issues/34)]
- Added an alias property of `Username` for `AuthorHandle` on output from `Get-BskyNotification`.

### Changed

- Revised the module manifest description.
- Increased the refresh interval for the session runspace to 60 minutes. This should reduce the number of API calls. __This is a potential breaking change,__
- Cleaned up code to ensure consistency with commands. References to an endpoint should all use the same variable, `$apiUrl`. Responses from the API should all use the `$response` variable.
- Updated `Get-BskyBlockedUser` and the associated format file to show the date the account was blocked.
- Help updates.
- Updated `README.md`.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}

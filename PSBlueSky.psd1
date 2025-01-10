#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.2.0'
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
        'Get-BskyTimeline'
        'New-BskyPost',
        'Open-BskyHelp',
        'Publish-BskyPost',
        'Repost-BskyPost',
        'Start-BskySession'
        'Update-BskySession'
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
    VariablesToExport    = ''
    AliasesToExport      = @(
        'skeet',
        'Refresh-BskySession',
        'bshelp',
        'bsn',
        'bsp',
        'bsfeed',
        'bsfollow',
        'bsfollower',
        'bst',
        'bsu',
        'bss',
        'bsblock',
        'bsblocklist'
    )
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'adprotocol')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [2.2.0] - 2025-01-10

### Added

- Added command `Publish-BskyPost` with an alias of `Repost-BskyPost` which can be used to quote or repost. [[Issue #25](https://github.com/jdhitsolutions/PSBluesky/issues/25)]
- Added command `Get-BskyBlockedList` and associated format file. [[Issue #27](https://github.com/]jdhitsolutions/PSBluesky/issues/27)]
- Added command `Get-BskyBlockedUser` and associated format file.
- Added command `Get-BskyLiked` and associated format file.
- Added `-Today` parameter to `Get-BskyNotification` to only show notifications from the current day.
- Imported [PR #30](https://github.com/jdhitsolutions/PSBluesky/pull/30) from  [@jhoneill](https://github.com/jhoneill) to improve piping to `New-BskyPost`.
- Added properties `CID` to output from `Get-BskyLiked`,`Get-BskyNotification`,`Get-BskyTimeline`, and `Get-BskyFeed`. This is to support new commands for reposting and quoting.
- Added properties `URI` to output from `Get-BskyNotification`,`Get-BskyTimeline`, and `Get-BskyFeed`. This is to support new commands for reposting and quoting.
- Added a custom view called `Liked` to the `PSBlueskyTimelinePost.format.ps1xml`, `PSBlueskyLiked.format.ps1xml`, and `PSBlueskyFeed.format.ps1xml' files.


### Changed

- Changed output property `aturi` in `Get-BskyLiked` and `Get-BskyFeed` to `URI`. This is to support new commands for reposting and quoting. __This is a potential breaking change__
- Added support for gif files as an image upload type. The image will be static in the current release of Bluesky.
- Updated formatting files for `Get-BskyTimeline`, `Get-BskyLiked`, and `Get-BskyFeed` to highlight the number of likes.
- Help updates.
- Updated `README.md`.

### Removed

- Removed files previously marked as deprecated.

### Fixed

- Fixed a bug with loading localized help. [[Issue #29](https://github.com/jdhitsolutions/PSBluesky/issues/29)]
- Fixed image layout problems in the help PDF file.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

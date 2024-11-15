#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '1.3.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c)2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt. This module is written for PowerShell 7 and uses features like $PSStyle.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-BskyImage',
        'Find-BskyUser'
        'Get-BskyAccessToken',
        'Get-BskyFeed',
        'Get-BskyFollowers',
        'Get-BskyFollowing',
        'Get-BskyNotification'
        'Get-BskyProfile',
        'Get-BskySession',
        'Get-BskyTimeline'
        'New-BskyPost',
        'Open-BskyHelp',
        'Update-BskySession'
    )
    TypesToProcess       = @(
        'types/PSBlueSky.types.ps1xml'
    )
    FormatsToProcess     = @(
        'formats/PSBlueSkyTimelinePost.format.ps1xml',
        'formats/PSBlueskyProfile.format.ps1xml',
        'formats/PSBlueskyFollower.format.ps1xml',
        'formats/PSBlueskyFeed.format.ps1xml',
        'formats/PSBlueskySession.format.ps1xml',
        'formats/PSBlueskyNotification.format.ps1xml',
        'formats/PSBlueskySearchResult.format.ps1xml'
    )
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = 'skeet','Refresh-BskySession'
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'adprotocol')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [1.3.0] - 2024-11-15

### Added

- Added command `Find-BSkyUser` and corresponding format file.
- Added code to get the text of referenced posts and cache them in a hashtable. The caching hashtable is referenced by a module-scoped variable.

### Changed

- Modified commands to use a user's DID instead of the username or handle. Some API endpoints don't work well with handles. __This is a possible breaking change__ [[Issue #18](https://github.com/jdhitsolutions/PSBluesky/issues/18)]
- Minor code cleanup and refactoring. Increased the use of splatting to improve code readability.
- Updated the profile object to include the account DID.
- Modified formatting and the default object for Bluesky notifications to include the text of a reference post that is either liked or reposted. __This is a breaking change.__
- Updated `Get-BskyNotification` to allow filtering by notification type.
- Updated formatting file for notifications to support additional notification types.
- Updated help documentation.
- Updated `README.md`

### Fixed

- Added support for `repost` and `reply` notifications in the `PSBlueskyNotification.format.ps1xml` file. [[Issue #17](https://github.com/jdhitsolutions/PSBluesky/issues/17)]
- Fixed notification hyperlinks in `PSBlueskyNotification.format.ps1xml`.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

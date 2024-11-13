#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '1.2.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt. This module is written for PowerShell 7 and uses features like $PSStyle.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-BskyImage',
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
        'formats/PSBlueskyNotification.format.ps1xml'
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
## [1.2.0] - 2024-11-13

### Added

- Added the alias `Alt` for `ImageAlt` in `New-BskyPost`.
- Added alias `Refresh-BskySession` for `Update-BskySession`
- Accepted [PR #12](https://github.com/jdhitsolutions/PSBluesky/pull/12) to fix casing issues which were causing problems loading the module on Linux. Thanks [@Skatterbrainz](https://github.com/Skatterbrainz)!
- Added additional verbose messaging to commands to show what platform is being used and the module version.
- Added command `Get-BskyNotification` and corresponding format file.

### Changed

- Updated `Get-BskyFollowers` to use paging to get all followers. [PR #11](https://github.com/jdhitsolutions/PSBluesky/pull/12) Thanks to [@Skatterbrainz](https://github.com/Skatterbrainz) for solving an issue on my to do list.
- Updated `New-BskyPost` to properly handle mentions and format as inline links. [[Issue #14](https://github.com/jdhitsolutions/PSBluesky/issues/14)]
- Update `Get-BskyFollowing` to allow the user to get all accounts. [[Issue #16](https://github.com/jdhitsolutions/PSBluesky/issues/16)]
- Major update to the way the module handles the session object and tokens. The module uses a background runspace to update the session object every 15 minutes. This should keep your Bluesky access tokens good for as long as the module is loaded without having to worrying about refreshing the module. __This is a breaking change__.
- Updated `README.md` to reflect changes and new features.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

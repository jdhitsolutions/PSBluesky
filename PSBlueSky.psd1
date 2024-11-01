#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBluesky.psm1'
    ModuleVersion        = '0.6.0'
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
        'Get-BskyProfile',
        'Get-BskySession',
        'Get-BskyTimeline'
        'New-BskyPost',
        'Open-BskyHelp'
    )
    TypesToProcess       = @(
        'types/PSBluesky.types.ps1xml'
    )
    FormatsToProcess = @(
        'formats/PSBlueskyTimelinePost.format.ps1xml',
        'formats/PSBlueskyProfile.format.ps1xml',
        'formats/PSBlueskyFollower.format.ps1xml',
        'formats/PSBlueskyFeed.format.ps1xml',
        'formats/PSBlueskySession.format.ps1xml'
    )
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = 'skeet'
    PrivateData          = @{
        PSData = @{
             Tags = @("Bluesky","skeet")
             LicenseUri = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
             ProjectUri = 'https://github.com/jdhitsolutions/PSBluesky'
            # IconUri = ''
            ReleaseNotes = @'
## [0.6.0] - 2024-11-01

This is the first version published to the PowerShell Gallery.

### Added

- Added command `Open-BskyHelp` to open a PDF version of the module's `README.md` file.
- Added custom format file for `PSBlueskySession` objects.
- Added alias properties `AccessToken` and `RefreshToken` for the `PSBlueskySession` object.

### Changed

- Updated help documentation
'@
            # Prerelease = ''
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

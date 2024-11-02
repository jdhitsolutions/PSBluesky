#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBluesky.psm1'
    ModuleVersion        = '1.0.0'
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
    FormatsToProcess     = @(
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
            Tags                       = @('Bluesky', 'skeet')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [1.0.0] - 2024-11-02

### Changed

- Renamed help PDF file to `PSBlueSky-Help.pdf`. This is probably a break change but since the expectation is to run `Open-BskyHelp` (which has been updated with the new file name) to open the file, it shouldn't be an issue.
- Updated `New-BskyPost` to support Markdown style links. [[Issue #6](https://github.com/jdhitsolutions/PSBluesky/issues/6)]
- Updated `README.md`.
- Updated module manifest to version `1.0.0`. This should be a very stable version with almost all of the intended functionality.
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

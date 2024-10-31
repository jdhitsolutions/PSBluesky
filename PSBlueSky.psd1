#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBluesky.psm1'
    ModuleVersion        = '0.5.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt.'
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
        'New-BskyPost'
    )
    TypesToProcess       = @(
        'types/PSBluesky.types.ps1xml'
    )
    FormatsToProcess = @(
        'formats/PSBlueskyTimelinePost.format.ps1xml',
        'formats/PSBlueskyProfile.format.ps1xml',
        'formats/PSBlueskyFollower.format.ps1xml',
        'formats/PSBlueskyFeed.format.ps1xml'
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
## [0.5.0] - 2024-10-31

### Added

- Added command `Get-BskySession`.
- Added a ScriptProperty called `Age` for the profile type objects.
- Added an Alias property of `Name` for `UserName` in the profile type objects.
- Added a property set called `Stats` for timeline and feed objects.

### Changed

- Updated the module to re-use and refresh Bluesky sessions. This should help with API rate limits since the commands aren't creating a new session for each request. [[Issue #7](https://github.com/jdhitsolutions/PSBluesky/issues/7)] __This is a breaking change__.
- Modified `Get-BskyProfile` to default the username to the specified credential. [[Issue #8](https://github.com/jdhitsolutions/PSBluesky/issues/8)]
- Renamed module commands. Example `Get-PSBlueskyProfile` is now `Get-BskyProfile`. __This is a breaking change__
- Documentation updates and corrections.
- Modified commands that write Profile type objects to use the accounts username for the DisplayName, if the `DisplayName` is not defined.
- Updated Pester tests.
'@
            # Prerelease = ''
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

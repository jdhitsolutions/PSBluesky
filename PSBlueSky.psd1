#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.0.0'
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
        'Get-BskyFeed',
        'Get-BskyFollowers',
        'Get-BskyFollowing',
        'Get-BskyNotification'
        'Get-BskyProfile',
        'Get-BskySession',
        'Get-BskyModuleInfo',
        'Get-BskyTimeline'
        'New-BskyPost',
        'Open-BskyHelp',
        'Start-BskySession'
        'Update-BskySession'
    )
    TypesToProcess       = @(
        'types/PSBlueSky.types.ps1xml'
    )
    FormatsToProcess     = @(
        'formats\PSBlueSkyTimelinePost.format.ps1xml',
        'formats\PSBlueskyProfile.format.ps1xml',
        'formats\PSBlueskyFollower.format.ps1xml',
        'formats\PSBlueskyFeed.format.ps1xml',
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
        'bsu'
    )
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'adprotocol')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [2.0.0] - 2024-11-18

### Added

- Added script property called `Age` for types `PSBlueskyProfile`, `PSBlueskyFollowProfile`, and `PSBlueskySearchResult`.
- Added custom verbose messaging and localized string data.
- Added typename `PSBlueskyImageUpload` to `Add-BskyImage`.
- Added command `Get-BskyModuleInfo` and corresponding formatting file.
- Added a parameter to `Open-BskyHelp` to view the file as a markdown document.
- Added support for proper notifications and tags in new messages. [[Issue #19](https://github.com/jdhitsolutions/PSBluesky/issues/19)]
- Added command aliases:
    - bsfeed --> `Get-BskyFeed`
    - bsfollow --> `Get-BskyFollowing`
    - bsfollower --> `Get-BskyFollowers`
    - bshelp --> `Open-BskyHelp`
    - bsn --> `Get-BskyNotification`
    - bsp --> `Get-BskyProfile`
    - bst --> `Get-BskyTimeline`
    - bsu --> `Find-BskyUser`
    - Refresh-BskySession --> `Update-BskySession`
    - skeet --> `New-BskyPost`

### Changed

- Modified commands to __not__ require a credential except for `Start-BskySession`. Commands will get the access token from the session object. __This is a breaking change__ [[Issue #20](https://github.com/jdhitsolutions/PSBluesky/issues/20)]

### Removed

- Removed `Get-BskyAccessToken` and replaced it with `Start-BskySession`. __This is a breaking change__
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

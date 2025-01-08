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
        'Get-BskyBlockedUser',
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
        'bsu',
        'bss',
        'bsblock'
    )
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Bluesky', 'skeet','API', 'adprotocol')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSBlueSky/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSBluesky'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSBlueSky/main/images/BlueskyLogo-icon.png'
            ReleaseNotes               = @'
## [2.1.0] - 2024-11-21

### Added

- Added alias `bss` for `Get-BskySession`.
- Added function `Get-BskyAccountDID`.
- Added parameter validation on image uploads to verify the image file size is less than 1MB.
- Merged [PR #23](https://github.com/jdhitsolutions/PSBluesky/pull/23) from [@jhoneill](https://github.com/jhoneill) to add label support for `New-BskyPost` and `-Username` to `Get-BskyFeed`.
- Added command `Get-BskyAccountDID`. This command does not require authentication.

### Changed

- Made `PostCache` a global-scoped variable and renamed it to `BskyPostCache``. Thanks to [@ShaunLawrie](https://github.com/ShaunLawrie) for the suggestion
- Revised parameter validations on `ImagePath` to provide more granular error messages.
- Updated `README` with documentation about setting up a credential using an app password.
- Revised `OnRemove` handler to remove type customizations. This should eliminate errors on module re-import in the same session.

### Removed

- Removed `gif` as a valid image type to upload.

### Fixed

- Modified `New-BskyPost` to re-order items that require facets so that the message is properly formatted. [[Issue #22](https://github.com/jdhitsolutions/PSBluesky/issues/22)]
'@
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

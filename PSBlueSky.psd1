#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '2.1.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c)2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt. This module is written for PowerShell 7 and uses features like $PSStyle.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-BskyImage',
        'Find-BskyUser',
        'Get-BskyAccountDID'
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
            ReleaseNotes               = ''
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

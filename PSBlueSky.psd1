#
# Module manifest for module 'PSBluesky'
#
@{
    RootModule           = 'PSBluesky.psm1'
    ModuleVersion        = '0.4.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the Bluesky API. You can skeet and upload images from a PowerShell prompt.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = @(
        'Add-PSBlueskyImage',
        'Get-PSBlueskyAccessToken',
        'Get-PSBlueskyFeed',
        'Get-PSBlueskyFollowers',
        'Get-PSBlueskyFollowing',
        'Get-PSBlueskyProfile',
        'Get-PSBlueskyTimeline'
        'New-PSBlueskyPost'
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
             ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

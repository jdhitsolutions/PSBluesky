#
# Module manifest for module 'PSBlueSky'
#
@{
    RootModule           = 'PSBlueSky.psm1'
    ModuleVersion        = '0.1.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'c5c1fd1d-e648-432d-b7d6-bb56f2044c2a'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2024 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands that use the BlueSky API. You can skeet and upload images from a PowerShell prompt.'
    PowerShellVersion    = '7.4'
    FunctionsToExport    = 'Add-PSBlueSkyImage', 'Get-PSBlueSkyAccessToken', 'Get-PSBlueSkyProfile',
    'New-PSBlueSkyPost'
    CmdletsToExport      = ''
    VariablesToExport    = ''
    AliasesToExport      = 'skeet'
    PrivateData          = @{
        PSData = @{
             Tags = @("bluesky","skeet")
             LicenseUri = ''
             ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable

}

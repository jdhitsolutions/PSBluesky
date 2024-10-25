BeforeDiscovery {
    # Import the module manifest
    $module = $PSCommandPath.Replace('.tests.ps1', '.psd1')
    #set a global variable so I can use this in my tests
    $global:modulePath = Join-Path -Path .. -ChildPath (Split-Path $module -Leaf)
    $ModuleName = (Get-Item $global:modulePath).BaseName
    If (Test-Path $global:modulePath) {
        Import-Module $global:modulePath -Force
    }
    else {
        Write-Warning "Can't find module at $global:modulePath"
    }
}

Describe "Module $ModuleName" -Tag Module {
    BeforeAll {
        #only need to get the module once
        $thisModule = Test-ModuleManifest -Path $global:modulePath
    }
    AfterAll {
        Remove-Variable -Name modulePath -Scope Global
    }

    Context Manifest {
        It 'Should have a module manifest' {
            $modulePath | Should -Exist
            $thisModule.ModuleType | Should -Be 'Script'
        }
        It 'Should have a defined RootModule' {
            $thisModule.RootModule | Should -Be "$($thisModule.Name).psm1"
        }
        It 'Should have a module version number that follows semantic versioning' {
            $thisModule.Version | Should -BeOfType [Version]
        }
        It 'Should have a defined description' {
            $thisModule.Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a GUID' {
            $thisModule.Guid | Should -BeOfType [Guid]
        }
        It 'Should have an Author' {
            $thisModule.Author | Should -Not -BeNullOrEmpty
        }
        It 'Should have a CompanyName' {
            $thisModule.CompanyName | Should -Not -BeNullOrEmpty
        }
        It 'Should have a Copyright' {
            $thisModule.Copyright | Should -Not -BeNullOrEmpty
        }
        It 'Should have a minimal PowerShellVersion' {
            $thisModule.PowerShellVersion | Should -BeOfType [Version]
        }
        It 'Should have defined CompatiblePSEditions' {
            $thisModule.CompatiblePSEditions.count | Should -BeGreaterThan 0
        }
        It 'Should have a LicenseUri' {
            $thisModule.PrivateData.PSData.licenseUri | Should -Not -BeNullOrEmpty
        } -pending
        It 'Should have a defined ProjectURI' {
            $thisModule.PrivateData.PSData.ProjectUri | Should -Not -BeNullOrEmpty
        } -pending
        It 'Should have defined tags' {
            $thisModule.PrivateData.PSData.Tags.count | Should -BeGreaterThan 0
        } -pending

    }
    Context 'Module Content' {
        It 'Should have a changelog file' {
            "..\changelog.md" | Should -Exist
        }
        It 'Should have a license file' {
            "..\license.txt" | Should -Exist
        }
        It 'Should have a README file'  {
            "..\README.md" | Should -Exist
        }
        It 'Should have a docs folder' {
            "..\docs" | Should -Exist
        }
        It 'Should have a markdown file for every exported function' {
            $functions =$thisModule.ExportedFunctions
            $functions.GetEnumerator() | ForEach-Object {
                $mdFile = "..\docs\$(.Key).md"
                $mdFile | Should -Exist
            }
        } -pending
        It 'Should have external help' {
            "..\en-us"  | Should -Exist
            "..\en-us\OSDetail-help.xml" | Should -Exist
        } -pending
        It 'Should have a Pester test' {
            #this is probably silly since I'm using a Pester test.
            ".\*tests.ps1" | Should -Exist
        }
    }
}

InModuleScope $Module {
    Describe FunctionToTest {
        It "does something useful" {
            $true | Should -Be $true
            }
        }
}

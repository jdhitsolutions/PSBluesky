BeforeDiscovery {
    # Import the module manifest
    $module = $PSCommandPath.Replace('.tests.ps1', '.psd1')
    #set a global variable so I can use this in my tests
    $global:ModulePath = Join-Path -Path .. -ChildPath (Split-Path $module -Leaf) -Resolve
    $ModuleName = (Get-Item $global:ModulePath).BaseName
    If (Test-Path $global:ModulePath) {
        Import-Module $global:ModulePath -Force -PassThru
    }
    else {
        Write-Warning "Can't find module at $global:ModulePath"
    }
}

Describe "Module $ModuleName" -Tag Module {
    BeforeAll {
        #only need to get the module once
        Write-Host "Testing module at $global:ModulePath" -ForegroundColor cyan
        $global:tm = $thisModule = Test-ModuleManifest -Path $global:ModulePath
    }
    AfterAll {
        Remove-Variable -Name ModulePath -Scope Global
    }

    Context Manifest {
        It 'Should have a module manifest' {
            $global:ModulePath | Should -Exist
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
        }
        It 'Should have a defined ProjectURI' {
            $thisModule.PrivateData.PSData.ProjectUri | Should -Not -BeNullOrEmpty
        }
        It 'Should have defined tags' {
            $thisModule.PrivateData.PSData.Tags.count | Should -BeGreaterThan 0
        }

    }
    Context 'Module Content' {
        It 'Should have a changelog file' {
            '..\changelog.md' | Should -Exist
        }
        It 'Should have a license file' {
            '..\license.txt' | Should -Exist
        }
        It 'Should have a README file' {
            '..\README.md' | Should -Exist
        }
        It 'Should have a docs folder' {
            '..\docs' | Should -Exist
        }
        It 'Should have a markdown file for every exported function' {
            $functions = $thisModule.ExportedFunctions
            $functions.GetEnumerator() | ForEach-Object {
                $mdFile = "..\docs\$($_.Key).md"
                $mdFile | Should -Exist
            }
        }
        It 'Should have external help' {
            '..\en-us' | Should -Exist
            '..\en-us\PSBluesky-help.xml' | Should -Exist
        }
        It 'Should have a Pester test' {
            #this is probably silly since I'm using a Pester test.
            '.\*tests.ps1' | Should -Exist
        }
    }
}

InModuleScope $ModuleName {

    Describe New-BskyPost {
        It 'Should have help documentation' {
        (Get-Help New-BskyPost).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name New-BskyPost).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { New-BskyPost } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyTimeline {
        It 'Should have help documentation' {
        (Get-Help Get-BskyTimeline).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyTimeline).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyTimeline } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskySession {
        It 'Should have help documentation' {
        (Get-Help Get-BskySession).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskySession).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskySession } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyProfile {
        It 'Should have help documentation' {
        (Get-Help Get-BskyProfile).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyProfile).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyProfile } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyFollowing {
        It 'Should have help documentation' {
        (Get-Help Get-BskyFollowing).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyFollowing).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyFollowing } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyFollowers {
        It 'Should have help documentation' {
        (Get-Help Get-BskyFollowers).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyFollowers).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyFollowers } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyFeed {
        It 'Should have help documentation' {
        (Get-Help Get-BskyFeed).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyFeed).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyFeed } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BskyAccessToken {
        It 'Should have help documentation' {
        (Get-Help Get-BskyAccessToken).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BskyAccessToken).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BskyAccessToken } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Add-BskyImage {
        It 'Should have help documentation' {
        (Get-Help Add-BskyImage).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Add-BskyImage).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Add-BskyImage } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
}

Function Get-BskyPreference {
    [cmdletbinding()]
    [OutputType('BskyPreference')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Specify a preference setting.'
        )]
        [ValidateScript({ $bskyPreferences.Contains($_) }, ErrorMessage = "The setting '{0}' was not found as a preference")]
        [string]$Setting
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
    }

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        $items = $bskyPreferences.GetEnumerator()
        if ($Setting) {
            _verbose ($strings.GetPref -f $Setting)
            $items = $items.Where({ $_.key -eq $Setting })
        }
        else {
            _verbose $strings.GetAllPref
        }

        $items | ForEach-Object {
            [PSCustomObject]@{
                PSTypename = 'BskyPreference'
                Setting    = $_.key
                Style      = "{0}{1}`e[0m" -f $_.value, ($_.value -replace "`e", '`e')
            }
        } #foreach
    }
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    }
}

Function Set-BskyPreference {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('BskyPreference', 'None')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the preference setting to change.'
        )]
        [ValidateScript({ $bskyPreferences.Contains($_) }, ErrorMessage = "The setting '{0}' was not found as a preference")]
        [string]$Setting,
        [string]$Style,
        [switch]$Passthru
    )
    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
        [regex]$rx = "^$([char]27)\[\d+[\d;]+m$"
        $StyleString = $Style -Replace "`e", '`e'
    }
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        #Moved parameter validation on the Style parameter to the code which better accommodates the escape character
        if ($Style -notmatch $rx) {
            Write-Warning -Message ($strings.StyleWarning -f $StyleString)
            return
        }
        if ($bskyPreferences.Contains($Setting)) {
            #Don't using this syntax because it won't preserve casing of the setting
            #$bskyPreferences[$Setting] = $Style
            $i = -1

            do {
                $i++
            } until ($bskyPreferences.keys[$i] -eq $Setting)

            $should = $strings.ShouldProcessSetting -f $Setting,$Style,$StyleString,$PSStyle.Reset
            If ($PSCmdlet.ShouldProcess($should)) {
                $bskyPreferences.Item($i) = $Style
                if ($Passthru) {
                    Get-BskyPreference -Setting $Setting
                }
            }
        }
        else {
            Write-Warning -Message ($strings.SettingNotFound -f $Setting)
        }
    }
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    }
}

Function Export-BskyPreference {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('System.IO.FileInfo')]
    Param(
        [switch]$Passthru
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
    }
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose ($strings.ExportPref -f $prefPath)
        $bskyPreferences | ConvertTo-Json | Out-File -FilePath $prefPath -Encoding utf8
        if ($Passthru -AND (-Not $WhatIfPreference)) {
            Get-Item -Path $prefPath
        }
    }

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    }
}

#delete the preference file
Function Remove-BskyPreferenceFile {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    Param()

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
    }

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        if (Test-Path -Path $prefPath) {
            _verbose ($strings.RemovingPref -f $prefPath)
            Remove-Item -Path $prefPath
        }
        else {
            Write-Warning -Message $strings.NoPrefFile
        }
    }
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    }
}

Register-ArgumentCompleter -CommandName Set-BskyPreference, Get-BskyPreference -ParameterName Setting -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

   ($bskyPreferences.keys).Where({ $_ -like "$wordToComplete*" }) |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
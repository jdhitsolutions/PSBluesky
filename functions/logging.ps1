#commands to manage API Trace logging

#enable logging by setting $bskyLogging to $True
Function Enable-BskyLogging {
    [cmdletbinding()]
    [OutputType('None', 'BskyLoggingInfo')]
    Param(
        [switch]$Passthru
    )
    $script:BskySession.LoggingEnabled = $True
    If ($Passthru) {
        Get-BskyLogging
    }

    #create a global variable to hold the log file path
    Set-Variable -Name bskyLogFile -Value (Get-BskyLogging).LogFile -Scope Global
}

Function Disable-BskyLogging {
    [cmdletbinding()]
    [OutputType('None', 'BskyLoggingInfo')]
    Param(
        [switch]$Passthru
    )
    $script:BskySession.LoggingEnabled = $False
    If ($Passthru) {
        Get-BskyLogging
    }
}

Function Get-BskyLogging {
    [cmdletbinding()]
    [OutputType('BSkyLoggingInfo')]
    Param()

    #write-verbose "Detected logging status: $($global:bskyLoggingEnabled)"
    $status = [PSCustomObject]@{
        PSTypeName     = 'BSkyLoggingInfo'
        LoggingEnabled = $script:BskySession.LoggingEnabled
        LogFile        = $script:BskySession.LogFile
        LogFileSize    = (Get-Item $script:BskySession.LogFile -ErrorAction SilentlyContinue).length
    }
    $status
}

Function Remove-BskyLogging {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    Param()

    If (Test-Path -Path $script:BskySession.LogFile) {
        Remove-Item $script:BskySession.LogFile
    }
    else {
        Write-Warning ($strings.NoLogFile -f $script:BskySession.LogFile)
    }
}

Function Set-BskyLogging {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None', 'BskyLoggingInfo')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Specify the file name and path for the log JSON file.'
        )]
        [ValidatePattern('\w+\.json$', ErrorMessage = 'The file name must end with .json')]
        [ValidateScript({ Split-Path $_ | Test-Path }, ErrorMessage = 'The parent folder cannot be verified.')]
        [string]$Path,
        [Parameter(HelpMessage = 'Show the new API logging settings')]
        [switch]$Passthru
    )

    #convert the Path to a file system path
    $Path = Convert-Path $Path
    if ($PSCmdlet.ShouldProcess($Path)) {
        $script:BskySession.LogFile = $Path
        #update the global variable to hold the log file path
        Set-Variable -Name bskyLogFile -Value $Path -Scope Global
        if ($Passthru) {
            Get-BskyLogging
        }
    } #WhatIf
}

#region helper functions

#These functions are also copied to the runspace code
Function _newLogData {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]$apiUrl,
        [Parameter(Mandatory)]
        [string]$Command
    )

    [regex]$rx = '((app)|(com)|(chat))(\.\w+){3}'
    $ep = $rx.match($apiUrl).value
    <#
    27 Jan 2025
    Adding a property of PID to the logging file because it is possible you might
    be logging from multiple PowerShell instances
    #>
    [PSCustomObject]@{
        Date     = Get-Date
        PID      = $PID
        Uri      = $apiUrl
        Endpoint = $rx.match($apiUrl).value
        Name     = $ep.split('.')[-1]
        Command  = $command
        Host     = $Host.Name
    }
}

Function _updateLog {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline, Mandatory)]
        [object]$InputObject,
        [string]$Path = $script:BskySession.LogFile
    )
    Begin {
        if ($script:BskySession.LoggingEnabled) {
            $existing = [System.Collections.Generic.List[object]]::new()
            #import existing data if found
            if (Test-Path $Path) {
                $existing.AddRange([object[]](Get-Content -Path $Path -Raw | ConvertFrom-Json))
            }
        } #if Logging
    }
    Process {
        if ($script:BskySession.LoggingEnabled) {
            $existing.Add($InputObject)
        }
    }
    End {
        If ($script:BskySession.LoggingEnabled) {
            $existing | ConvertTo-Json | Out-File -FilePath $Path -Force -Encoding utf8
        }
    }
}
#endregion
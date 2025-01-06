# 17 Nov 2024 This command has been deprecated in favor of Start-BskySession

Return
Function Get-BskyAccessToken {
    [cmdletbinding()]
    [OutputType("[System.String]")]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential,
        [switch]$Passthrough
    )

    Begin {
$PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
$PSDefaultParameterValues["_verbose:block"] = "Begin"
_verbose -message $strings.Starting

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    #Hide this metadata when the command is called from another command
    _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
    _verbose -message ($strings.UsingHost -f $host.Name)
    _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
    _verbose -message ($strings.UsingModule -f $ModuleVersion)
}
    } #begin

    Process {
        if ($Null -eq $script:BSkySession) {
           # Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating a new Bluesky session for $($Credential.UserName)"
           # _CreateSession -Credential $Credential
           Start-BskySession -Credential $Credential
        }
        elseif ((-Not ($script:BSkySession.active)) -OR ($script.BSkySession.Age.TotalMinutes -ge 15)) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Refreshing the Bluesky session for $($Credential.UserName)"
            Update-BskySession -RefreshToken $script:BSkySession.refreshJwt
        }
        else {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using the existing Bluesky session for $($Credential.UserName)"
            $script:BSkySession.accessJwt
        }
    } #process
    End {
          $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
  $PSDefaultParameterValues["_verbose:block"] = "End"
  _verbose $strings.Ending
    }
}
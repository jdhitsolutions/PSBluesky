Function Get-BskyAccessToken {
    [cmdletbinding()]
    [OutputType([System.String])]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running module version $ModuleVersion"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running on $($PSVersionTable.OS)"
        }
    } #begin

    Process {
        if ($Null -eq $script:BSkySession) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating a new Bluesky session for $($Credential.UserName)"
            _CreateSession -Credential $Credential
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
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    }
}
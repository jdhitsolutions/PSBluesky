Function Get-BskyAccessToken {
    [cmdletbinding()]
    [OutputType([System.String])]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    if ($Null -eq $script:BSkySession) {
        Write-Verbose "Creating a new Bluesky session for $($Credential.UserName)"
        _CreateSession -Credential $Credential
    }
    elseif ((-Not ($script:BSkySession.active)) -OR ($script.BSkySession.Age.TotalMinutes -ge 60)) {
        Write-Verbose "Refreshing the Bluesky session for $($Credential.UserName)"
        Update-BskySession -RefreshToken $script:BSkySession.refreshJwt
    }
    else {
        Write-Verbose "Using the existing Bluesky session for $($Credential.UserName)"
        $script:BSkySession.accessJwt
    }
}

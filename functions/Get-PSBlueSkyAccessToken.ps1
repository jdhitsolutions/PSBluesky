Function Get-PSBlueskyAccessToken {
    [cmdletbinding()]
    [OutputType([System.String])]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    #Create a logon session
    $headers = @{
        'Content-Type' = 'application/json'
    }

    $LogonURL = "$PDSHOST/xrpc/com.atproto.server.createSession"
    $body = @{
        identifier = $Credential.UserName
        password   = $Credential.GetNetworkCredential().Password
    } | ConvertTo-Json
    Write-Verbose "[$((Get-Date).TimeOfDay)] Creating a Bluesky logon session for $($Credential.UserName)"
    $BSkySession = Invoke-RestMethod -Uri $LogonURL -Method Post -Headers $headers -Body $Body
    if ($BSkySession.accessJwt) {
        $BSkySession.accessJwt
    }
    else {
        Write-Warning 'Failed to authenticate.'
    }

}

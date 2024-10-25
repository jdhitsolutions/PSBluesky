Function Get-PSBlueSkyAccessToken {
    [cmdletbinding()]
    [OutputType([System.String])]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your BlueSky username and password')]
        [PSCredential]$Credential
    )

    #Create a logon session
    $headers = @{
        'Content-Type' = 'application/json'
    }

    $LogonURL = "$($global:PDSHOST)/xrpc/com.atproto.server.createSession"
    $body = @{
        identifier = $Credential.UserName
        password   = $Credential.GetNetworkCredential().Password
    } | ConvertTo-Json
    Write-Verbose "[$((Get-Date).TimeOfDay)] Creating a BlueSky logon session for $($Credential.UserName)"
    $BSkySession = Invoke-RestMethod -Uri $LogonURL -Method Post -Headers $headers -Body $Body
    if ($BSkySession.accessJwt) {
        $BSkySession.accessJwt
    }
    else {
        Write-Warning 'Failed to authenticate.'
    }

}

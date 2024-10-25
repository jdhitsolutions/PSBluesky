Function Get-PSBlueSkyProfile {
    [CmdletBinding()]
    [OutputType('PSBlueSkyProfile')]
    Param(
        [Parameter(Mandatory, HelpMessage = 'Enter the profile or user name.')]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
        [string]$UserName,
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your BlueSky username and password')]
        [PSCredential]$Credential
    )

    $token = Get-PSBlueSkyAccessToken -Credential $Credential
    If ($token) {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Querying for $Username"

        $apiUrl = "$($global:PDSHOST)/xrpc/app.bsky.actor.getProfile?actor=$UserName"
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $apiUrl"
        $headers = @{
            Authorization  = "Bearer $token"
            'Content-Type' = 'application/json'
        }

        $profile = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
        If ($profile) {
            Write-Information -MessageData ($profile | Out-String) -Tags raw
            [PSCustomObject]@{
                PSTypeName  = 'PSBlueSkyProfile'
                Username    = $profile.handle
                Display     = $profile.displayName
                Created     = $profile.createdAt
                Description = $profile.description
                Avatar      = $profile.avatar
                Posts       = $profile.postsCount
                Followers   = $profile.followersCount
                Following   = $profile.followsCount
                Lists       = $profile.associated.lists
            }
        }
        else {
            Write-Warning 'Failed to retrieve profile.'
        }
    }
    else {
        Write-Warning 'Failed to authenticate.'
    }
}

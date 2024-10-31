Function Get-BskyProfile {
    [CmdletBinding()]
    [OutputType('PSBlueskyProfile')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the profile or user name.'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
        [string]$UserName,
        [Parameter(
            Mandatory,
            HelpMessage = 'A PSCredential with your Bluesky username and password'
        )]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
        $token = Get-BskyAccessToken -Credential $Credential
        Write-Information $script:BSkySession -Tags raw
    } #begin

    Process {
        #use the credential username if the username is not provided
        if (-Not ($PSBoundParameters.ContainsKey('UserName'))) {
            $Username = $Credential.UserName
        }

        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Querying for $Username"

            $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.getProfile?actor=$UserName"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $apiUrl"
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }

            Try {
            $profile = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop
            If ($profile) {
                Write-Information -MessageData $profile -Tags raw
                [PSCustomObject]@{
                    PSTypeName  = 'PSBlueskyProfile'
                    Username    = $profile.handle
                    Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                    Created     = $profile.createdAt.ToLocalTime()
                    Description = $profile.description
                    Avatar      = $profile.avatar
                    Posts       = $profile.postsCount
                    Followers   = $profile.followersCount
                    Following   = $profile.followsCount
                    Lists       = $profile.associated.lists
                    URL         = "https://bsky.app/profile/$($profile.handle)"
                }
            }
            else {
                Write-Warning "Failed to retrieve profile for $Username."
            }
        } #Try
        Catch {
            Write-Error $_
        }
        }
        else {
            Write-Warning 'Failed to authenticate.'
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
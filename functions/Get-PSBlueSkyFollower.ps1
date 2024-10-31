#https://docs.bsky.app/docs/api/app-bsky-graph-get-followers

Function Get-BskyFollowers {
    [CmdletBinding()]
    [OutputType('PSBlueskyFollowProfile')]
    Param(
        [Parameter(HelpMessage = "Enter the number of followers to retrieve between 1 and 100. Default is 50.")]
        [ValidateRange(1,100)]
        [int]$Limit = 50,
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
        $token = Get-BskyAccessToken -Credential $Credential
        $UserName = $Credential.UserName
    } #begin
    Process {
        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Querying $limit followers for $Username"

            $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollowers?limit=$Limit&actor=$UserName"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing: $apiUrl"
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }

            $Followers = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
            If ($Followers) {
                Write-Information -MessageData $Followers -Tags raw
                foreach ($profile in $Followers.Followers) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyFollowProfile'
                        Username    = $profile.handle
                        Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                        Created     = $profile.createdAt.ToLocalTime()
                        Description = $profile.description
                        URL         = "https://bsky.app/profile/$($profile.handle)"
                    }
                }
            }
            else {
                Write-Warning 'Failed to retrieve followers.'
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


Function Get-BskyFollowers {
    [CmdletBinding()]
    [OutputType('PSBlueskyFollowProfile')]
    Param(
        [Parameter(HelpMessage = "Enter the number of followers to retrieve between 1 and 100. Default is 50.")]
        [ValidateRange(1,100)]
        [int]$Limit = 50,
        [Parameter(HelpMessage = "Return All followers")]
        [switch]$All,
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

            if (!$All.IsPresent) {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollowers?limit=$Limit&actor=$UserName"
            } else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollowers?limit=100&actor=$UserName"
            }
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing: $apiUrl"
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }

            $results = @()
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
            If ($response) {
                $results += $response.followers
                # iterate remaining pages using 'cursor' response value
                while ($response.cursor) {
                    $url = $apiUrl+"&cursor=$($response.cursor)"
                    $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                    If ($response.followers) {
                        $results += $response.followers
                    }
                }
                Write-Information -MessageData $Followers -Tags raw
                foreach ($profile in $results) {
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

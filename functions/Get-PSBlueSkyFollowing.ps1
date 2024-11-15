#https://docs.bsky.app/docs/api/app-bsky-graph-get-follows
Function Get-BskyFollowing {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [OutputType('PSBlueskyFollowProfile')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of accounts that you follow to retrieve between 1 and 100. Default is 50.',
            ParameterSetName = 'Limit'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(ParameterSetName = 'All', HelpMessage = 'Return All followers')]
        [switch]$All,
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
        $token = Get-BskyAccessToken -Credential $Credential
        $UserName = $Credential.UserName
        $did = $script:BskySession.did
    } #begin
    Process {
        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Querying $limit response accounts for $Username"

            if ($PSCmdlet.ParameterSetName -eq 'Limit') {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollows?limit=$Limit&actor=$did"
            }
            else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollows?limit=100&actor=$did"
            }
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing: $apiUrl"
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }

            $results = @()
            $splat = @{
                Uri         = $apiUrl
                Method      = 'Get'
                Headers     = $headers
                ErrorAction = 'Stop'
                ResponseHeadersVariable = 'rh'
            }
            $response = Invoke-RestMethod @splat
            Write-Information -MessageData $rh -tags ResponseHeader
            If ($response) {
                $results += $response.follows
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS]  Getting all following accounts from $($response.cursor)"
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        If ($response.follows) {
                            $results += $response.follows
                        }
                    }
                } #If All

                 Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing $($results.Count) accounts"
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


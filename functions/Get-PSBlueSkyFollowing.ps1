#https://docs.bsky.app/docs/api/app-bsky-graph-get-follows
Function Get-BskyFollowing {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [Alias('bsfollow')]
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
        [switch]$All
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
        if ($script:BSkySession.accessJwt) {
            $token = $script:BSkySession.accessJwt
            $UserName = $script:BSkySession.handle
            $did = $script:BskySession.did
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }
            Write-Information $script:BSkySession -Tags raw
        }
        else {
            Write-Warning $strings.NoSession
        }
    } #begin
    Process {

        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        If ($headers) {

            _verbose -message ($strings.QueryFollowing -f $limit, $UserName)

            if ($PSCmdlet.ParameterSetName -eq 'Limit') {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollows?limit=$Limit&actor=$did"
            }
            else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollows?limit=100&actor=$did"
            }
            _verbose $apiUrl
            $results = @()
            $splat = @{
                Uri                     = $apiUrl
                Method                  = 'Get'
                Headers                 = $headers
                ErrorAction             = 'Stop'
                ResponseHeadersVariable = 'rh'
            }
            $response = Invoke-RestMethod @splat
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            If ($response) {
                $results += $response.follows
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                     # 25 April 2025 add support for Write-Progress Issue #40
                     $count = 0
                     #get the approximate number of following accounts
                     $Max = (Get-BskyProfile).Following
                     $progParams = @{
                         Activity = $strings.ProgressActivity2
                         Status   =($strings.ProgressStatus2 -f 0)
                         Percent  = 0
                     }
                    _verbose -message ($strings.PageFollowing -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        [int]$progParams.Percent = ($count / $Max) * 100
                        $progParams.Status = ($strings.ProgressStatus2 -f $progParams.Percent)
                        Write-Progress @progParams
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                        If ($response.follows) {
                            $results += $response.follows
                            $count += $response.follows.count
                        }
                    }
                } #If All

                _verbose -message ($strings.ProcessAccounts -f $results.Count)
                foreach ($profile in $results) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyFollowProfile'
                        Username    = $profile.handle
                        Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                        Created     = $profile.createdAt.ToLocalTime()
                        Description = $profile.description
                        URL         = "https://bsky.app/profile/$($profile.handle)"
                        Avatar      = $profile.avatar
                        Labels      = $profile.Labels.val
                    }
                }
            }
            else {
                Write-Warning $strings.FailFollowing
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}


Function Get-BskyFollowers {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [Alias('bsfollower')]
    [OutputType('PSBlueskyFollowProfile')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of followers to retrieve between 1 and 100. Default is 50.',
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
            
            if ($PSCmdlet.ParameterSetName -eq 'Limit') {
                _verbose -message ($strings.GetFollowers -f $limit,$UserName)
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollowers?limit=$Limit&actor=$did"
            }
            else {
                _verbose -message ($strings.GetFollowers -f "ALL",$UserName)
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getFollowers?limit=100&actor=$did"
            }

            _verbose $apiUrl

            $results = @()
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            If ($response) {
                $results += $response.followers
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                    # 25 April 2025 add support for Write-Progress Issue #40
                    $count = 0
                    #get the approximate number of followers
                    $Max = (Get-BskyProfile).Followers
                    $progParams = @{
                        Activity = $strings.ProgressActivity1
                        Status   =($strings.ProgressStatus1 -f 0)
                    }
                    _verbose -message ($strings.PageFollowers -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        [int]$progParams.Percent = ($count / $Max) * 100
                        $progParams.Status = ($strings.ProgressStatus1 -f $progParams.Percent)
                        Write-Progress @progParams
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                        If ($response.followers) {
                            _verbose -message ($strings.RetrievedFollowers -f $response.followers.count)
                            Write-Information -MessageData $response -Tags raw
                            $results += $response.followers
                            $count += $response.followers.count
                        }
                    }
                    Write-Progress @progParams -Completed
                } #If All
                foreach ($profile in $results) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyFollowProfile'
                        Username    = $profile.handle
                        Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                        Created     = $profile.createdAt.ToLocalTime()
                        Description = $profile.description
                        URL         = "https://bsky.app/profile/$($profile.handle)"
                        DID         = $profile.did
                        Avatar      = $profile.avatar
                        Labels      = $profile.Labels.val
                    }
                }
            } #if response
            else {
                Write-Warning $strings.FailFollowers
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

#these are followers that you also follow
Function Get-BskyKnownFollowers {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [OutputType('PSBlueskyFollowProfile')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of followers to retrieve between 1 and 100. Default is 50.',
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
            
            if ($PSCmdlet.ParameterSetName -eq 'Limit') {
                _verbose -message ($strings.GetKnownFollowers -f $limit,$UserName)
                $apiUrl = "$PDSHost/xrpc/app.bsky.graph.getKnownFollowers?limit=$Limit&actor=$did"
            }
            else {
                _verbose -message ($strings.GetKnownFollowers -f "ALL",$UserName)
                $apiUrl = "$PDSHost/xrpc/app.bsky.graph.getKnownFollowers?limit=100&actor=$did"
            }

            _verbose $apiUrl

            $results = @()
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            If ($response) {
                $results += $response.followers
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                    # 25 April 2025 add support for Write-Progress Issue #40
                    $count = 0
                    #get the approximate number of followers
                    $Max = (Get-BskyProfile).Followers
                    $progParams = @{
                        Activity = $strings.ProgressActivity1
                        Status   =($strings.ProgressStatus1 -f 0)
                    }
                    _verbose -message ($strings.PageFollowers -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        [int]$progParams.Percent = ($count / $Max) * 100
                        $progParams.Status = ($strings.ProgressStatus1 -f $progParams.Percent)
                        Write-Progress @progParams
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                        If ($response.followers) {
                            _verbose -message ($strings.RetrievedFollowers -f $response.followers.count)
                            Write-Information -MessageData $response -Tags raw
                            $results += $response.followers
                            $count += $response.followers.count
                        }
                    }
                    Write-Progress @progParams -Completed
                } #If All
                foreach ($profile in $results) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyFollowProfile'
                        Username    = $profile.handle
                        Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                        Created     = $profile.createdAt.ToLocalTime()
                        Description = $profile.description
                        URL         = "https://bsky.app/profile/$($profile.handle)"
                        DID         = $profile.did
                        Avatar      = $profile.avatar
                        Labels      = $profile.Labels.val
                    }
                }
            } #if response
            else {
                Write-Warning $strings.FailFollowers
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
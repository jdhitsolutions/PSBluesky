Function Get-BskyBlockedUser {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [Alias('bsblock')]
    [OutputType('PSBlueskyBlockedUser')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of blocked accounts to retrieve between 1 and 100. Default is 50.',
            ParameterSetName = 'Limit'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(ParameterSetName = 'All', HelpMessage = 'Return all blocked accounts')]
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
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getBlocks?limit=$Limit"
            }
            else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getBlocks?limit=100"
            }

            _verbose $apiUrl

            $results = @()
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ResponseHeadersVariable rh
            Write-Information -MessageData $rh -Tags ResponseHeader
            If ($response) {
                $results += $response.blocks
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                    _verbose -message ($strings.PageBlockedUsers -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        If ($response.followers) {
                            Write-Information -MessageData $response -Tags raw
                            $results += $response.followers
                        }
                    }
                } #If All
                foreach ($profile in $results) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyBlockedUser'
                        Username    = $profile.handle
                        Display     = ($profile.displayName) ? $profile.displayName : $profile.handle
                        Created     = $profile.createdAt.ToLocalTime()
                        Description = $profile.description
                        Labels      = $profile.labels.val
                        URL         = "https://bsky.app/profile/$($profile.handle)"
                        DID         = $profile.did
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

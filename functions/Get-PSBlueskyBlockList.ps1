Function Get-BskyBlockedList {
    [CmdletBinding(DefaultParameterSetName = 'Limit')]
    [Alias('bsblocklist')]
    [OutputType('PSBlueskyBlockedList')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of blocked lists to retrieve between 1 and 100. Default is 50.',
            ParameterSetName = 'Limit'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(ParameterSetName = 'All', HelpMessage = 'Return all blocked lists')]
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
          #  $UserName = $script:BSkySession.handle
          #  $did = $script:BskySession.did
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
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getListBlocks?limit=$Limit"
            }
            else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getListBlocks?limit=100"
            }

            _verbose $apiUrl

            $results = @()
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            If ($response) {
                $results += $response.lists
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                    _verbose -message ($strings.PageBlockedLists -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.cursor) {
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                        If ($response.followers) {
                            Write-Information -MessageData $response -Tags raw
                            $results += $response.followers
                        }
                    }
                } #If All
                foreach ($list in $results) {
                    #create a nested User object for the creator
                    $creator = [PSCustomObject]@{
                            PSTypeName  = 'PSBlueskySearchResult'
                            DisplayName = $list.Creator.displayName
                            UserName    = $list.Creator.handle
                            Description = $list.Creator.description
                            Avatar      = $list.Creator.avatar
                            Created     = $list.Creator.createdAt.ToLocalTime()
                            DID         = $list.Creator.did
                            URL         = "https://bsky.app/profile/$($list.Creator.did)"
                    }
                    $Purpose = Switch ($list.purpose.split("#")[1]) {
                        "modlist" {"Moderated list"}
                        "curatelist " {"Curated list"}
                        "referencelist" {"Reference list"}
                    }
                    #https://bsky.app/profile/did:plc:mcgh4jrag2bcgnhk3skn22dg/lists/3lcdwdnywx425
                    $split = $list.uri -split '/' | Where-Object { $_ -match '\w' }
                    $ListUrl = "https://bsky.app/profile/{0}/lists/{1}" -f $split[1],$split[-1]
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyBlockedList'
                        Name        = $list.Name
                        CreatedBy   = $creator
                        Description = $list.description
                        Purpose     = $Purpose
                        Labels      = $list.labels.val
                        Items       = $list.listItemCount
                        Indexed     = $list.indexedAt
                        URL         = $ListUrl
                    }
                }
            } #if response
            else {
                Write-Warning $strings.FailBlockList
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

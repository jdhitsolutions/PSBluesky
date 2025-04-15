
#https://docs.bsky.app/docs/api/app-bsky-graph-get-starter-pack
#this command does not require authentication
Function Get-BskyStarterPackList {
    [cmdletBinding(DefaultParameterSetName = 'Limit')]
    [Alias('bssplist')]
    [OutputType('PSBlueskyStarterPackList')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the at-uri for the starter pack.'
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Uri,

        [Parameter(
            HelpMessage = 'Enter the number of starter pack list items to retrieve between 1 and 100. Default is 50.',
            ParameterSetName = 'Limit'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,

        [Parameter(
            HelpMessage = 'Return All starter park list items',
            ParameterSetName = 'All'
        )]
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
        #this endpoint does not require authentication
        $PDSHost = 'https://public.api.bsky.app'
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'

        $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getStarterPack?starterPack=$Uri"

        _verbose $apiUrl

        Try {
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            if ($response) {
                Write-Information -MessageData $response -Tags raw

                $listUri = $response.starterPack.list.uri
                $listApiUrl = "$PDSHOST/xrpc/app.bsky.graph.getList?limit=$Limit&list=$listUri"

                $list = @()
                $listResponse = Invoke-RestMethod -Uri $listApiUrl -Method Get -ResponseHeadersVariable rh
                _verbose $listApiUrl

                _newLogData -apiUrl $listApiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
                if ($listResponse) {
                    $list += $listResponse
                    Write-Information -MessageData $list -Tags raw
                    if ($PSCmdlet.ParameterSetName -eq 'All') {
                        _verbose -message ($strings.PageList -f $listResponse.cursor)
                        # iterate remaining pages using 'cursor' response value
                        while ($listResponse.cursor) {
                            $cursorUrl = $listApiUrl + "&cursor=$($listResponse.cursor)"
                            $listResponse = Invoke-RestMethod -Uri $cursorUrl -Method Get -Headers $headers
                            _verbose $cursorUrl

                            _newLogData -apiUrl $cursorUrl -command $MyInvocation.MyCommand | _updateLog
                            If ($listResponse) {
                                $list += $listResponse
                            }
                        }
                    } #If All
                }

                [PSCustomObject]@{
                    PSTypeName     = 'PSBlueskyStarterPackList'
                    Name           = $response.starterPack.record.name
                    Description    = $response.starterPack.record.description
                    Created        = $response.starterPack.record.createdAt.ToLocalTime()
                    Feeds          = $response.starterPack.record.feeds
                    Creator        = $response.starterPack.creator.handle
                    CreatorDisplay = $response.starterPack.creator.displayName
                    ListItems      = $list.items.subject
                    ListItemCount  = $response.starterPack.list.listItemCount
                    Labels         = $response.starterPack.labels
                    URL            = (_convertAT $response.starterPack.uri -type 'starter-pack')
                    URI            = $response.starterPack.uri
                    CID            = $response.starterPack.cid
                } #PSCustomObject

                if ($list.items.subject.count -lt $response.starterPack.list.listItemCount) {
                    Write-Warning ($strings.IncompleteList -f $response.starterPack.list.listItemCount, $list.items.subject.count)
                }
            } #if results
            else {
                Write-Warning ($strings.FailStarterPackList -f $Uri)
            }
        } #try
        Catch {
            Write-Error $_
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
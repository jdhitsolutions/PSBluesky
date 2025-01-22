#https://docs.bsky.app/docs/api/app-bsky-feed-get-timeline
Function Get-BskyTimeline {
    [CmdletBinding()]
    [Alias('bst')]
    [OutputType('PSBlueskyTimelinePost')]
    Param(
        [Parameter(HelpMessage = 'Enter the number of timeline posts to retrieve between 1 and 100. Default is 50.')]
        [ValidateRange(1, 100)]
        [int]$Limit = 50
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
            _verbose -message ($strings.GetTimeline -f $limit)
            $apiUrl = "$PDSHost/xrpc/app.bsky.feed.getTimeline?limit=$Limit"
            _verbose $apiUrl
            Try {
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
            }
            Catch {
                Write-Warning ($strings.FailTimeline -f $_.Exception.Message)
            }
            if ($response) {
                Write-Information -MessageData $response -Tags raw
                $timeline = Foreach ($item in $response.feed) {
                    [PSCustomObject]@{
                        PSTypeName    = 'PSBlueskyTimelinePost'
                        Author        = $item.post.author.handle
                        AuthorDisplay = $item.post.author.displayName
                        Date          = $item.post.record.createdAt.ToLocalTime()
                        Text          = $item.post.record.text
                        Liked         = $item.post.likeCount
                        Reposted      = $item.post.repostCount
                        Quoted        = $item.post.quoteCount
                        URL           = (_convertAT $item.post.uri)
                        URI           = $item.post.uri
                        CID           = $item.post.cid
                    } #PSCustomObject
                } #foreach item

                #sort the timeline by date
                $timeline | Sort-Object -Property Date -Descending
            } #if tl
        } #if headers

    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
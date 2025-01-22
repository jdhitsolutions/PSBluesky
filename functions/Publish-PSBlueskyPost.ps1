# repost or quote an existing post

<#
references
 https://docs.bsky.app/docs/advanced-guides/posts#quote-posts
 https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/embed/record.json
 https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/repost.json
#>

Function Publish-BskyPost {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("String")]
    [Alias("Repost-BskyPost")]
    Param (
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'The Bluesky post AT Uri'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^at://did:plc:.*$',
            ErrorMessage = 'The AT uri {0} is not valid.')]
        [string]$Uri,
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'The Bluesky post CID'
        )]
        [ValidateScript({ $_.length -eq 59 },
            ErrorMessage = 'The CID {0} is not valid. It should be a string of 59 characters like bafyreihvh4rrlumy5gqzkb5qdmlyqequuzruod6s3cnfzo6hezbj7yukmq')]
        [string]$CID,
        [Parameter(HelpMessage = 'Add quoted text. Otherwise the result will be a simple repost.')]
        [ValidateNotNullOrEmpty()]
        [string]$Quote
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

        $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.createRecord"
        if ($script:BSkySession.accessJwt) {
            $token = $script:BSkySession.accessJwt
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
    } #Begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        If ($quote) {
            _verbose ($strings.Quoting -f $Uri)
            $collection = 'app.bsky.feed.post'
            $record = [ordered]@{
                '$type'   = 'app.bsky.feed.post'
                text      = $Quote
                embed     = @{
                    '$type' = 'app.bsky.embed.record'
                    record  = @{
                        uri = $Uri
                        cid = $CID
                    }
                }
                createdAt = (Get-Date -Format 'o')
            }
        }
        else {
            _verbose ($strings.Reposting -f $Uri)
            $collection = 'app.bsky.feed.repost'
            $record = [ordered]@{
                '$type'   = 'app.bsky.feed.repost'
                subject   = @{
                    uri = $Uri
                    cid = $CID
                }
                createdAt = (Get-Date -Format 'o')
            }
        }
        Write-Information -MessageData $record -Tags record
        $body = @{
            repo       = $did
            collection = $collection
            record     = $record
        } | ConvertTo-Json -Depth 7

        Write-Information -MessageData $body -Tags raw
        if ($PSCmdlet.ShouldProcess($Uri, 'Publish to Bluesky')) {
            $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            #the URL to generate depends if this is a repost or a quote
            if ($Quote) {
                _convertAT $response.uri
            }
            else {
                _convertAT $uri
            }
            Write-Information -MessageData $response -Tags raw
        }
    } #Process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #End
}
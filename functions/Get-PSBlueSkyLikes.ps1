#Get a user's liked posts

#  https://docs.bsky.app/docs/api/app-bsky-feed-get-actor-likes

Function Get-BskyLiked {
    [cmdletbinding(DefaultParameterSetName = 'Limit')]
    [OutputType('PSBlueskyLikedItem')]
    [alias('bsliked')]
    Param(
        [Parameter(
            ParameterSetName = 'Limit',
            HelpMessage = 'Enter the number of liked posts to retrieve between 1 and 100. Default is 50.'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(
            ParameterSetName = 'All',
            HelpMessage = 'Return all liked posts'
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
                $apiUrl = "$PDSHOST/xrpc/app.bsky.feed.getActorLikes?actor=$($Username)&limit=$limit"
            }
            else {
                $apiUrl = "$PDSHOST/xrpc/app.bsky.feed.getActorLikes?actor=$($Username)&limit=100"
            }

            _verbose $apiUrl

            Try {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
            }
            Catch {
                Write-Warning ($strings.FailLiked -f $username, $_.Exception.Message)
            }
            $likes = @()
            if ($response) {
                $likes += $response.feed
                Write-Information -MessageData $response -Tags raw
                if ($PSCmdlet.ParameterSetName -eq 'All') {
                        # 25 April 2025 add support for Write-Progress Issue #40
                        $count = 0
                        $progParams = @{
                            Activity = $strings.ProgressActivity3
                            Status   =($strings.ProgressStatus3 -f 0)
                            Percent  = 0
                        }
                    _verbose -message ($strings.PageLikes -f $response.cursor)
                    # iterate remaining pages using 'cursor' response value
                    while ($response.feed.post.count -gt 0) {
                        $progParams.Status = ($strings.ProgressStatus3 -f $count)
                        Write-Progress @progParams
                        $url = $apiUrl + "&cursor=$($response.cursor)"
                        $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
                        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                        If ($response.feed.post.count -gt 0) {
                            Write-Information -MessageData $response -Tags raw
                            $likes += $response.feed
                            $count += $response.feed.post.count
                        }
                    }
                } #If All
                Write-Information -MessageData $likes -Tags raw
                foreach ($post in $likes.post) {
                    #use embedded images if found or external uri thumb
                $thumb = If ($post.embed.images.thumb) {
                    $post.embed.images.thumb
                }
                elseif ($item.post.embed.external ) {
                    $post.embed.external.thumb
                }
                    [PSCustomObject]@{
                        PSTypeName    = 'PSBlueskyLikedItem'
                        Text          = $post.record.text
                        Author        = $post.author.handle
                        AuthorUrl     = "https://bsky.app/profile/$($post.author.handle)"
                        AuthorDisplay = $post.author.displayName
                        Liked         = $post.likeCount
                        Replied       = $post.replyCount
                        Reposted      = $post.repostCount
                        Quoted        = $post.quoteCount
                        Date          = $post.record.createdAt.ToLocalTime()
                        URL           = _convertAT $post.uri
                        Labels        = $post.labels.val
                        URI           = $post.uri
                        CID           = $post.cid
                        Thumbnail     = $thumb
                        Links         = $post.embed.external.uri
                    }
                } #foreach like
            } #if likes
            else {
                #this should never get to to this point except for new accounts
                Write-Warning ($strings.FailLiked -f $username, $_.Exception.Message)
            }
        } #if headers
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
} #close function
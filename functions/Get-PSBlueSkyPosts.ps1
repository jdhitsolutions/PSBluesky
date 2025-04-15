#Get a user's recent posts

# https://docs.bsky.app/docs/api/app-bsky-feed-get-author-feed

Function Get-BskyFeed {
    [cmdletbinding()]
    [Alias('bsfeed')]
    [OutputType('PSBlueskyFeedItem')]

    Param(
        [Parameter(HelpMessage = 'Enter the number of accounts that you follow to retrieve between 1 and 100. Default is 50.')]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,

        [Parameter(HelpMessage = 'Enter the username of an account to retrieve their feed. The default is your feed.')]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile','Handle')]
        [string]$UserName
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
            if (-not $PSBoundParameters.ContainsKey('UserName')) {
                $UserName = $script:BSkySession.handle
            }
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
        <#
        this might become a parameter in a future release
        Possible values:
          posts_with_replies,
          posts_no_replies,
          posts_with_media,
          posts_and_author_threads
        #>
        $filter = 'posts_with_replies'
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        If ($headers) {
            _verbose -message ($strings.QueryFeed -f $limit, $Username)
            $filter = 'posts_with_replies'
            if ($PSBoundParameters.ContainsKey('UserName')) {
                $apiUrl = "$PDSHost/xrpc/app.bsky.feed.getAuthorFeed?actor=$UserName&limit=$Limit&filter=$filter"
            }
            else {
                $apiUrl = "$PDSHost/xrpc/app.bsky.feed.getAuthorFeed?actor=$did&limit=$Limit&filter=$filter"
            }

            _verbose $apiUrl

            Try {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
            }
            Catch {
                Write-Warning ($strings.FailFeed -f $username, $_.Exception.Message)
            }
            if ($response) {
                Write-Information -MessageData $response -Tags raw
                foreach ($post in $response.feed.post) {
                    [PSCustomObject]@{
                        PSTypeName    = 'PSBlueskyFeedItem'
                        Text          = $post.record.text
                        IsRepost      = ($post.viewer.repost) ? $True : $False
                        Author        = $post.author.handle
                        AuthorDisplay = $post.author.displayName
                        Liked         = $post.likeCount
                        Replied       = $post.replyCount
                        Reposted      = $post.repostCount
                        Quoted        = $post.quoteCount
                        Date          = $post.record.createdAt.ToLocalTime()
                        URL           = _convertAT $post.uri
                        URI           = $post.uri
                        CID           = $post.cid
                        Tags          = ($post.record.facets.features).Where({$_.tag}).tag
                        Thumbnail     = $post.embed.images.thumb
                    }
                } #foreach post
            } #if feed
            else {
                #this should never get to to this point except for new accounts
                Write-Warning ($strings.FailFeed -f $username, $_.Exception.Message)
            }
        } #if headers
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
} #close function
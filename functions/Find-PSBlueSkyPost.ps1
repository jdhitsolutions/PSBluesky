#Search for posts
# https://docs.bsky.app/docs/api/app-bsky-feed-search-posts
# https://bsky.app/profile/bnewbold.net/post/3lg4jigj4dc2v
# This is limited in functionality compared to what is documented.
# searching explicitly for tags isn't possible right now

Function Find-BskyPost {
    [cmdletbinding()]
    [OutputType('PSBlueskyFeedItem')]
    [Alias('bsf','Search-BskyPost')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter a search term or text')
        ]
        [ValidateNotNullOrEmpty()]
        [string]$Query,

        [Parameter(HelpMessage = 'Enter the number of posts to retrieve between 1 and 100. Default is 50.')]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,

        [Parameter(HelpMessage = 'Filter by a username')]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile', 'Handle')]
        [string]$UserName,

        [Parameter(HelpMessage = 'Filter by a language. The default is English (en).')]
        [ValidateNotNullOrEmpty()]
        [string]$Language = 'en',

        [Parameter(HelpMessage = 'Filter by posts since a specific date and time.')]
        [ValidateNotNullOrEmpty()]
        [Datetime]$Since
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
        #this commands queries a public API

        $headers = @{
            'Content-Type' = 'application/json'
        }
        $apiUrl = "https://public.api.bsky.app/xrpc/app.bsky.feed.searchPosts?limit=$limit&q=$Query&lang=$Language"
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        If ($Username) {
            Try {
                $DID = Get-BskyAccountDID -AccountName $Username -ErrorAction Stop
                $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
                $apiUrl += "&author=$DID"
            }
            Catch {
                Write-Warning ($strings.DIDFail -f $Username)
                return "$($PSStyle.Foreground.Red)$($_.Exception.Message)$($PSStyle.Reset)"
            }
        }
        If ($Since) {
            #convert to ISO date
            $apiUrl += "&since=$($Since.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ'))"
        }
        _verbose $apiUrl

        Write-Information $apiUrl -Tags process
        Try {
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
        }
        Catch {
            Write-Warning $_.Exception.Message
        }
        if ($response) {
            _verbose ($strings.FindPostCount -f $response.posts.Count)
            Write-Information -MessageData $response -Tags raw
            foreach ($post in $response.posts) {
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
                    Tags          = ($post.record.facets.features).Where({ $_.tag }).tag
                    Thumbnail     = $post.embed.images.thumb
                }
            } #foreach post
        } #if response
        else {
            #this should never get to to this point except for new accounts
            Write-Warning $strings.FailFind
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
} #close function
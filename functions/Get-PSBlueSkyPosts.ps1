#Get a user's recent posts

# https://docs.bsky.app/docs/api/app-bsky-feed-get-author-feed

Function Get-BskyFeed {
    [cmdletbinding()]
    [OutputType('PSBlueskyFeedItem')]

    Param(
        [Parameter(HelpMessage = 'Enter the number of accounts that you follow to retrieve between 1 and 100. Default is 50.')]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running module version $ModuleVersion"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running on $($PSVersionTable.OS)"
        }
        $token = Get-BskyAccessToken -Credential $Credential
        $Username = $Credential.UserName
        $did = $script:BskySession.did
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
        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Querying $limit feed items for $Username"
            $filter = 'posts_with_replies'
            $apiUrl = "$PDSHost/xrpc/app.bsky.feed.getAuthorFeed?actor=$did&limit=$Limit&filter=$filter"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing: $apiUrl"
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }
            Try {
                $feed = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
                Write-Information -MessageData $rh -tags ResponseHeader
            }
            Catch {
                Write-Warning "Failed to retrieve feed items for $username. $($_.Exception.Message)"
            }
            if ($Feed) {
                Write-Information -MessageData $feed -Tags raw
                foreach ($post in $feed.feed.post) {
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
                        aturi         = $post.uri
                    }
                } #foreach post
            } #if feed
            else {
                #this should never get to to this point except for new accounts
                Write-Warning 'Failed to retrieve feed items.'
            }
        } #if token
        else {
            Write-Warning 'Failed to authenticate.'
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
} #close function
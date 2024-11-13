#https://docs.bsky.app/docs/api/app-bsky-feed-get-timeline
Function Get-BskyTimeline {
    [CmdletBinding()]
    [OutputType('PSBlueskyTimelinePost')]
    Param(
        [Parameter(HelpMessage = "Enter the number of timeline posts to retrieve between 1 and 100. Default is 50.")]
        [ValidateRange(1,100)]
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
    } #begin
    Process {
        If ($token) {
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting $limit timeline posts"
            $URL = "$PDSHost/xrpc/app.bsky.feed.getTimeline?limit=$Limit"
            Try {
                $tl = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -ErrorAction Stop
            }
            Catch {
                Write-Warning "Failed to get timeline. $($_.Exception.Message)"
            }
            if ($tl) {
                Write-Information -MessageData $tl -Tags raw
                $timeline = Foreach ($item in $tl.feed) {
                    [PSCustomObject]@{
                        PSTypeName        = 'PSBlueskyTimelinePost'
                        Author            = $item.post.author.handle
                        AuthorDisplay     = $item.post.author.displayName
                        Date              = $item.post.record.createdAt.ToLocalTime()
                        Text              = $item.post.record.text
                        Liked             = $item.post.likeCount
                        Reposted          = $item.post.repostCount
                        Quoted            = $item.post.quoteCount
                        URL               = (_convertAT $item.post.uri)
                    } #PSCustomObject
                } #foreach item

                #sort the timeline by date
                $timeline | Sort-Object -Property Date -Descending
            } #if tl
        } #if token
        else {
            Write-Warning 'Failed to authenticate'
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
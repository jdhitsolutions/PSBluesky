# https://docs.bsky.app/docs/api/app-bsky-notification-list-notifications
Function Get-BskyNotification {
    [cmdletbinding()]
    [OutputType('PSBlueskyNotification')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the number of notifications to retrieve between 1 and 100. Default is 50.',
            ParameterSetName = 'Limit'
        )]
        [ValidateRange(1, 100)]
        [int]$Limit = 50,
        [Parameter(HelpMessage = 'Enter the type of notifications to retrieve. Default is All.')]
        [ValidateSet("All","Like","Follow","Repost","Mention","Reply")]
        [string]$Filter = "All",
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
        $headers = @{
            Authorization  = "Bearer $token"
            'Content-Type' = 'application/json'
        }

        #initialize a collection to store all notifications
        $all = [System.Collections.Generic.list[object]]::New()
    } #begin

    Process {
        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Retrieving $limit notifications"
            $url = "$PDSHOST/xrpc/app.bsky.notification.listNotifications?limit=$Limit"

            Try {
                $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
                Write-Information -MessageData $rh -tags ResponseHeader
            }
            Catch {
                Write-Warning "Failed to retrieve notifications. $($_.Exception.Message)"
            }
            If ($response.notifications) {
                Write-Information -MessageData $response -Tags raw
                foreach ($notification in $response.notifications) {
                    #resolve the subject text if available
                    # $script:PostCache is defined in the root module file
                    if (($notification.reasonSubject) -AND ($script:PostCache.ContainsKey($notification.reasonSubject))) {
                        $refText = $script:PostCache[$notification.reasonSubject]
                    }
                    elseif ($notification.reasonSubject) {
                        #get the text of the post
                        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Resolving post text for $($notification.reasonSubject)"
                        $refText = _getPostText -AT $notification.reasonSubject -Headers $headers
                        #update the caching hashtable
                        $script:PostCache[$notification.reasonSubject] = $refText
                    }
                    elseif ($notification.record.text) {
                        #the text is included in a mention
                        $refText = $notification.record.text
                    }
                    else {
                        $refText = $null
                    }

                    $refUrl = If ($notification.reasonSubject) {
                        _convertAT $notification.reasonSubject
                    }
                    elseif ($notification.uri ) {
                        _convertAT $notification.uri
                    }

                    $object = [PSCustomObject]@{
                        PSTypeName   = 'PSBlueSkyNotification'
                        Date         = $notification.IndexedAt.ToLocalTime()
                        Notification = $notification.reason
                        Author       = $notification.author.displayName
                        AuthorHandle = $notification.author.handle
                        AuthorUrl    = "https://bsky.app/profile/$($notification.author.handle)"
                        SubjectUrl   = $refUrl
                        Subject      = $refText
                    } #custom object

                    [Void]($all.Add($object))
                } #foreach notification
            } #if notifications
        } #if token
        else {
            Write-Warning 'Failed to authenticate.'
        }
    } #process

    End {
        #filter the notifications by type if specified
        if ($Filter -ne 'All') {
            Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Filtering notifications by type: $Filter"
            $all | Where-Object { $_.Notification -eq $Filter }
        }
        else {
            $all
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
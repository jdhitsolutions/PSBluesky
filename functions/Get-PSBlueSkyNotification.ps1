# https://docs.bsky.app/docs/api/app-bsky-notification-list-notifications
Function Get-BskyNotification {
    [cmdletbinding()]
    [Alias('bsn')]
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
        [ValidateSet('All', 'Like', 'Follow', 'Repost', 'Mention', 'Reply')]
        [string]$Filter = 'All'
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

        #initialize a collection to store all notifications
        $all = [System.Collections.Generic.list[object]]::New()
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        If ($headers) {

            _verbose -message ($strings.GetNotification -f $limit)
            $url = "$PDSHOST/xrpc/app.bsky.notification.listNotifications?limit=$Limit"

            Try {
                $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -ErrorAction Stop -ResponseHeadersVariable rh
                Write-Information -MessageData $rh -Tags ResponseHeader
            }
            Catch {
                Write-Warning ($strings.FailNotification -f $_.Exception.Message)
            }
            If ($response.notifications) {
                Write-Information -MessageData $response -Tags raw
                foreach ($notification in $response.notifications) {
                    #resolve the subject text if available
                    # $global:PostCache is defined in the root module file
                    if (($notification.reasonSubject) -AND ($global:PostCache.ContainsKey($notification.reasonSubject))) {
                        $refText = $global:PostCache[$notification.reasonSubject]
                    }
                    elseif ($notification.reasonSubject) {
                        #get the text of the post
                        _verbose -message ($strings.ResolveText -f $notification.reasonSubject)
                        $refText = _getPostText -AT $notification.reasonSubject -Headers $headers
                        #update the caching hashtable
                        $global:PostCache[$notification.reasonSubject] = $refText
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
        } #if headers
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        #filter the notifications by type if specified
        if ($Filter -ne 'All') {
            _verbose -message ($strings.FilterNotification -f $Filter)
            $all | Where-Object { $_.Notification -eq $Filter }
        }
        else {
            $all
        }
        _verbose $strings.Ending
    } #end
}
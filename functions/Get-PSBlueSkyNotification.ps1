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
    } #begin

    Process {
        If ($token) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Retrieving $limit notifications"
            $url = "$PDSHOST/xrpc/app.bsky.notification.listNotifications?limit=$Limit"

            Try {
                $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -ErrorAction Stop
            }
            Catch {
                Write-Warning "Failed to retrieve notifications. $($_.Exception.Message)"
            }
            If ($response.notifications) {
                Write-Information -MessageData $response -Tags raw
                foreach ($notification in $response.notifications) {
                    [PSCustomObject]@{
                        PSTypeName   = 'PSBlueSkyNotification'
                        Date         = $notification.IndexedAt.ToLocalTime()
                        Notification = $notification.reason
                        Author       = $notification.author.displayName
                        AuthorHandle = $notification.author.handle
                        AuthorUrl    = "https://bsky.app/profile/$($notification.author.handle)"
                        Subject      = $notification.reasonSubject ? (_convertAT $notification.reasonSubject) : $null
                    }
                }
            }
        }
        else {
            Write-Warning 'Failed to authenticate.'
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
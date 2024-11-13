Function Update-BskySession {
    [CmdletBinding()]
    [Alias('Refresh-BskySession')]
    [OutputType('PSBlueskySession')]
    Param (
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'The refresh token'
        )]
        [string]$RefreshToken
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running module version $ModuleVersion"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running on $($PSVersionTable.OS)"
        }
    } #begin

    Process {
        #Refresh a Bluesky session
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] Refreshing a Bluesky logon session for $($script:BSkySession.handle)"
        $headers = @{
            Authorization  = "Bearer $RefreshToken"
            'Content-Type' = 'application/json'
        }
        $RefreshUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
        Try {
            $splat = @{
                Uri         = $RefreshUrl
                Method      = 'Post'
                Headers     = $headers
                ErrorAction = 'Stop'
            }
            $script:BSkySession = Invoke-RestMethod @splat
            $script:accessJwt = $script:BSkySession.accessJwt
            $script:refreshJwt = $script:BSkySession.refreshJwt
            #return the session
            $script:BSkySession | _newSessionObject
        } #try
        Catch {
            Write-Warning "Failed to authenticate or refresh the session. $($_.Exception.Message)"
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
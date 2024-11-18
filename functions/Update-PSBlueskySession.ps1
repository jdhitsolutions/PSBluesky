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
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        #Refresh a Bluesky session
        _verbose -message ($strings.RefreshSession -f $script:BSkySession.handle)
        $headers = @{
            Authorization  = "Bearer $RefreshToken"
            'Content-Type' = 'application/json'
        }
        $RefreshUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
        Try {
            $splat = @{
                Uri                     = $RefreshUrl
                Method                  = 'Post'
                Headers                 = $headers
                ErrorAction             = 'Stop'
                ResponseHeadersVariable = 'rh'
            }
            $script:BSkySession = Invoke-RestMethod @splat
            Write-Information -MessageData $rh -Tags ResponseHeader
            $script:accessJwt = $script:BSkySession.accessJwt
            $script:refreshJwt = $script:BSkySession.refreshJwt
            #return the session
            $script:BSkySession | _newSessionObject
        } #try
        Catch {
            Write-Warning ($strings.FailRefresh -f $_.Exception.Message)
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end

}
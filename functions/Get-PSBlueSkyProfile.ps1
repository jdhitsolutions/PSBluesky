#https://docs.bsky.app/docs/api/app-bsky-actor-get-profile
Function Get-BskyProfile {
    [CmdletBinding()]
    [Alias('bsp')]
    [OutputType('PSBlueskyProfile')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the profile or user name.'
        )]
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
            #use the session handle if the username is not provided
            if (-Not ($PSBoundParameters.ContainsKey('UserName'))) {
                $Username = $script:bSkySession.handle
            }

            _verbose ($strings.UserSearch -f $Username)

            $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.getProfile?actor=$UserName"

            _verbose $apiUrl

            Try {
                $splat = @{
                    Uri                     = $apiUrl
                    Method                  = 'Get'
                    Headers                 = $headers
                    ErrorAction             = 'Stop'
                    ResponseHeadersVariable = 'rh'
                }
                $bSkyProfile = Invoke-RestMethod @splat
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
                If ($bSkyProfile) {
                    Write-Information -MessageData $bSkyProfile -Tags raw
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskyProfile'
                        Username    = $bSkyProfile.handle
                        Display     = ($bSkyProfile.displayName) ? $bSkyProfile.displayName : $bSkyProfile.handle
                        Created     = $bSkyProfile.createdAt.ToLocalTime()
                        Description = $bSkyProfile.description
                        Avatar      = $bSkyProfile.avatar
                        Posts       = $bSkyProfile.postsCount
                        Followers   = $bSkyProfile.followersCount
                        Following   = $bSkyProfile.followsCount
                        Lists       = $bSkyProfile.associated.lists
                        URL         = "https://bsky.app/profile/$($bSkyProfile.handle)"
                        DID         = $bSkyProfile.did
                        Viewer      = $bSkyProfile.viewer
                        Labels     = $bSkyProfile.labels.val
                    }
                }
                else {
                    Write-Warning ($strings.FailProfile -f $Username)
                }
            } #Try
            Catch {
                Write-Error $_
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
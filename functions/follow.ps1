#region Follow a Bluesky profile

Function New-BskyFollow {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('String')]
    [Alias("Follow-BskyUser")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the profile or user name.'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
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
            $did = $script:BSkySession.did
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
        if ($Headers) {
            $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.getProfile?actor=$UserName"
            _verbose ($strings.UserSearch -f $Username)
            Try {
                $splat = @{
                    Uri                     = $apiUrl
                    Method                  = 'Get'
                    Headers                 = $headers
                    ErrorAction             = 'Stop'
                    ResponseHeadersVariable = 'rh'
                }
                $User = Invoke-RestMethod @splat
                Write-Information -MessageData $rh -Tags ResponseHeader
                Write-Information -MessageData $User -Tags raw
            }
            Catch {
                Write-Error $_
            }
            If ($User) {
                $FollowDid = $User.did
                $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.createRecord"

                $record = [ordered]@{
                    '$type'   = 'app.bsky.graph.follow'
                    subject   = $FollowDid
                    createdAt = (Get-Date -Format 'o')
                }

                $body = @{
                    repo       = $did
                    collection = 'app.bsky.graph.follow'
                    record     = $record
                } | ConvertTo-Json

                Write-Information -MessageData $body -Tags raw

                _verbose ($strings.Following -f $Username)
                if ($PSCmdlet.ShouldProcess($Username)) {
                    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
                    #output should be the followed account page
                    "https://bsky.app/profile/$($FollowDid)"
                }
            } #if user found
            else {
                Write-Warning ($strings.FailProfile -f $Username)
            }
        } #if headers

    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

#endregion


#region Un-follow a Bluesky profile
# https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json
# https://docs.bsky.app/docs/api/com-atproto-repo-delete-record

Function Remove-BskyFollow {
    [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName = 'User')]
    [OutputType('None','PSObject')]
    [Alias("Unfollow-BskyUser")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = 'User',
            HelpMessage = 'Enter the profile or user name.'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
        [string]$UserName,

        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            ParameterSetName = 'DID',
            HelpMessage = 'Enter the profile DID'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('^did:plc:[a-z0-9]{24}$', ErrorMessage = 'Invalid DID format')]
        [string]$DID,
        [switch]$Passthru
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
            $did = $script:BSkySession.did
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
        if ($headers) {
            $PSDefaultParameterValues['_verbose:block'] = 'Process'
            If ($PSCmdlet.ParameterSetName -eq 'User') {
                $account = $UserName
            }
            else {
                $account = $DID
            }
            _verbose ($strings.UserSearch -f $account)
            $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.getProfile?actor=$account"
            Try {
                $splat = @{
                    Uri                     = $apiUrl
                    Method                  = 'Get'
                    Headers                 = $headers
                    ErrorAction             = 'Stop'
                    ResponseHeadersVariable = 'rh'
                }
                $User = Invoke-RestMethod @splat
                Write-Information -MessageData $rh -Tags ResponseHeader
                Write-Information -MessageData $user -Tags raw
            }
            Catch {
                Write-Warning ($strings.FailProfile -f $account)
                Write-Error $_
            }

            If ($User.viewer.following) {
                $rkey = $user.viewer.following.split('/')[-1]

                $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.deleteRecord"
                $body = @{
                    repo       = $did
                    collection = 'app.bsky.graph.follow'
                    rkey       = $rkey
                } | ConvertTo-Json

                $splat = @{
                    Uri     = $apiUrl
                    Method  = 'Post'
                    Headers = $headers
                    Body    = $body
                }
                Write-Information -MessageData $splat -Tags raw

                if ($PSCmdlet.ShouldProcess($User.handle)) {
                    $delResponse = Invoke-RestMethod @splat
                    Write-Information -MessageData $delResponse -Tags raw
                    if ($Passthru -AND (-Not $WhatIfPreference)) {
                        $delResponse.commit
                    }
                }

            } #if viewer property found
            else {
                Write-Warning ($strings.NotFollowing -f $user.handle)
            }
        } #if headers detected
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

#endregion
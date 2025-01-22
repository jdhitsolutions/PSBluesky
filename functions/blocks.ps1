#https://gist.github.com/TundraShark/c1c1043672b0be13b0905c84d908a30d
# https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/block.json

Function Block-BskyUser {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'User')]
    [OutputType('None','PSObject')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            ParameterSetName = 'User',
            HelpMessage = 'Enter the profile or user name.'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
        [string]$UserName,

        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ParameterSetName = 'Input',
            HelpMessage = 'A Bluesky profile object'
        )]
        [Object]$InputObject,

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
                Try {
                    $BlockedDID = (Get-BskyProfile -UserName $UserName -ErrorAction Stop).did
                    $User = $Username
                }
                Catch {
                    Throw $_
                }
            }
            else {
                $BlockedDID = $InputObject.did
                $User = $InputObject.UserName
            }
            _verbose ($strings.BlockingUser -f $user)

            $record = @{
                '$type'   = 'app.bsky.graph.block'
                subject   = $blockedDID
                createdAt = (Get-Date -Format 'o')
            }
            $body = @{
                repo       = $did
                collection = 'app.bsky.graph.block'
                record     = $record
            } | ConvertTo-Json

            $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.createRecord"
            If ($PSCmdlet.ShouldProcess("$User [$BlockedDID]")) {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body -ResponseHeadersVariable rh
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
                Write-Information -MessageData $response -Tags raw
                if ($Passthru) {
                    $response
                }
            }
        } #if headers
        else {
            _verbose $strings.NoSession
        }
    }
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

Function Unblock-BskyUser {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None','PSObject')]
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
            $User = Get-BskyProfile -UserName $UserName -ErrorAction Stop

            _verbose ($strings.BlockingUser -f $UserName)

            $rkey = $user.viewer.blocking.split('/')[-1]
            $body = @{
                repo       = $did
                collection = 'app.bsky.graph.block'
                rkey       = $rkey
                record = @{
                    '$type' = "app.bsky.graph.block"
                    subject = $user.did
                    createdAt = (Get-Date -Format 'o')
                }
            } | ConvertTo-Json

            $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.deleteRecord"
            If ($PSCmdlet.ShouldProcess($BlockedDID)) {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body -ResponseHeadersVariable rh
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                Write-Information -MessageData $rh -Tags ResponseHeader
                Write-Information -MessageData $response -Tags raw
                if ($Passthru) {
                    $response
                }
            }
        } #if headers
        else {
            _verbose $strings.NoSession
        }
    }
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
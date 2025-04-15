
#https://docs.bsky.app/docs/api/app-bsky-graph-get-actor-starter-packs
#this command does not require authentication
Function Get-BskyStarterPack {
    [cmdletBinding()]
    [Alias('bssp')]
    [OutputType('PSBlueskyStarterPack')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the profile or username.'
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
        #this endpoint does not require authentication
        $PDSHost = 'https://public.api.bsky.app'
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'

        #use the session handle if the username is not provided
        if (-Not ($PSBoundParameters.ContainsKey('UserName'))) {
            if ($script:BSkySession.handle) {
                $Username = $script:bSkySession.handle
            }
            else {
                Write-Warning $strings.NoSessionStarterPack
                Break
            }
        }

        _verbose -message ($strings.UserSearch -f $Username)

        $apiUrl = "$PDSHOST/xrpc/app.bsky.graph.getActorStarterPacks?actor=$UserName"

        _verbose $apiUrl

        Try {
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            Write-Information -MessageData $response -Tags raw
            if ($response.starterPacks.count -gt 0) {
                Foreach ($item in $response.starterPacks) {

                    [PSCustomObject]@{
                        PSTypeName         = 'PSBlueskyStarterPack'
                        Name               = $item.record.name
                        Description        = $item.record.description
                        Created            = $item.record.createdAt.ToLocalTime()
                        Feeds              = $item.record.feeds
                        Creator            = $item.creator.handle
                        CreatorDisplay     = $item.creator.displayName
                        JoinedWeekCount    = $item.joinedWeekCount
                        JoinedAllTimeCount = $item.joinedAllTimeCount
                        Labels             = $item.labels
                        URL                = (_convertAT $item.uri -type 'starter-pack')
                        URI                = $item.uri
                        CID                = $item.cid
                    } #PSCustomObject
                } #foreach item
            } #if results
            else {
                Write-Warning ($strings.FailStarterPacks -f $Username)
            }
        } #try
        Catch {
            Write-Error $_
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
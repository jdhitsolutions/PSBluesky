
#https://docs.bsky.app/docs/api/app-bsky-actor-search-actors
#this command does not require authentication
Function Find-BskyUser {
    [cmdletBinding()]
    [Alias('bsu')]
    [OutputType('PSBlueskySearchResult')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter a search string.'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Profile')]
        [string]$UserName,
        [Parameter(HelpMessage = 'Enter the number of results to retrieve between 1 and 100. Default is 50.')]
        [ValidateRange(1, 100)]
        [int]$Limit = 50
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

        _verbose -message ($strings.UserSearch -f $Username)

        $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.searchActors?q='$UserName'&limit=$Limit"

        _verbose $apiUrl
        Try {
            $response = Invoke-RestMethod -Uri $apiUrl -Method Get -ResponseHeadersVariable rh
            _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
            Write-Information -MessageData $rh -Tags ResponseHeader
            Write-Information -MessageData $response -Tags raw
            If ($response.actors.count -gt 0) {
                Foreach ($item in $response.actors) {
                    [PSCustomObject]@{
                        PSTypeName  = 'PSBlueskySearchResult'
                        DisplayName = $item.displayName
                        UserName    = $item.handle
                        Description = $item.description
                        Avatar      = $item.avatar
                        Created     = $item.createdAt.ToLocalTime()
                        DID         = $item.did
                        URL         = "https://bsky.app/profile/$($item.did)"
                    } #PSCustomObject
                } #foreach item
            } #if results
            else {
                _verbose ($strings.NoSearchResults -f $Username)
                Write-Warning ($strings.NoSearchResults -f $Username)
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
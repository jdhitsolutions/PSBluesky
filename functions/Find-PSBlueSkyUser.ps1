
#https://docs.bsky.app/docs/api/app-bsky-actor-search-actors
Function Find-BskyUser {
    [cmdletBinding()]
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
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running module version $ModuleVersion"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running on $($PSVersionTable.OS)"
        }
        #this endpoint does not require authentication
        $PDSHost = 'https://public.api.bsky.app'
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Searching for $Username"

        $apiUrl = "$PDSHOST/xrpc/app.bsky.actor.searchActors?q='$UserName'&limit=$Limit"

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $apiUrl"
        Try {
            $results = Invoke-RestMethod -Uri $apiUrl -Method Get -ResponseHeadersVariable rh
            Write-Information -MessageData $rh -Tags ResponseHeader
            Write-Information -MessageData $results -Tags raw
            If ($results.actors.count -gt 0) {
                Foreach ($item in $results.actors) {
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
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] No results found for $Username"
                Write-Warning "No results found for $Username"
            }
        } #try
        Catch {
            Write-Error $_
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
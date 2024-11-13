Function Get-BskySession {
    [cmdletbinding()]
    [OutputType('PSBlueskySession')]
    Param()

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
        if ($script:BSkySession) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS Found an existing Bluesky session"
            Write-Information -MessageData $script:BSkySession -tag data
            $script:BSkySession | _newSessionObject
        }
        else {
            Write-Warning 'No Existing Bluesky session found. Have you created an access token or run a module command like Get-BskyFeed?'
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
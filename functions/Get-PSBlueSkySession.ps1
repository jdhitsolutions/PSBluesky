Function Get-BskySession {
    [cmdletbinding()]
    [Alias('bss')]
    [OutputType('PSBlueskySession')]
    Param()

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
        if ($script:BSkySession) {
            if ($script:BSkySession.Handle) {
                Write-Verbose ($strings.SessionFound -f $script:BSkySession.handle)
            }
            else {
                Write-Warning $strings.NoSession
            }
            Write-Information -MessageData $script:BSkySession -tag data
            $script:BSkySession | _newSessionObject
        }
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
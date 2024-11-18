Function Start-BSkySession {
    [cmdletbinding()]
    [OutputType('PSBlueskySession')]

    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
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
        _verbose -message ($strings.NewSession -f $Credential.UserName)
        _CreateSession -Credential $Credential
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}
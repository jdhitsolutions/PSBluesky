Function Get-BskyModuleInfo {
    [CmdletBinding()]
    [OutputType('PSBlueskyModuleInfo')]
    Param(
        [Parameter(HelpMessage = "Get commands that match the given verb.")]
        [ArgumentCompleter({(Get-Verb).Verb})]
        [string]$Verb = "*",
        [Parameter(HelpMessage = "Get commands that match the given noun.")]
        [SupportsWildcards()]
        [string]$Noun="*"
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        #Hide this metadata when the command is called from another command
        _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
        _verbose -message ($strings.UsingHost -f $host.Name)
        _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
        _verbose -message ($strings.UsingModule -f $ModuleVersion)

        $ModuleName = 'PSBlueSky'
        $cmds = @()
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose -message ($strings.GetModuleInfo -f $ModuleName)
        $mod = Get-Module -Name $ModuleName

        _verbose -message ($strings.GetFunctions)
        #6 May 2025 added filtering for Verb and Noun
        $cmds += $mod.ExportedFunctions.keys | 
        Get-Command | Where-Object {$_.Verb -Like $verb -AND $_.noun -Like $Noun}

        _verbose -message ($strings.FoundCommands -f $cmds.count)

        foreach ($cmd in $cmds) {
            _verbose -message ($strings.ProcessCommand -f $cmd.Name)
            #get aliases, ignoring errors for those commands without one
            $alias = (Get-Alias -Definition $cmd.Name -ErrorAction SilentlyContinue).name

            [PSCustomObject]@{
                PSTypeName = 'PSBlueskyModuleInfo'
                Name       = $cmd.name
                Alias      = $alias
                Synopsis   = (Get-Help $cmd.name).synopsis.trim()
                Type       = $cmd.CommandType
                Version    = $cmd.version
                Help       = $cmd.HelpUri
                ModuleName = $mod.name
                Compatible = $mod.CompatiblePSEditions
                PSVersion  = $mod.PowerShellVersion
            }
        } #foreach cmd

    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end

} #end function
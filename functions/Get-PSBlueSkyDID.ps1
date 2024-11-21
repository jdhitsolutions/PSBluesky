#this command does not require authentication
Function Get-BskyAccountDID {
    [CmdletBinding()]
    [OutputType('System.String')]
    Param (
        [Parameter(Position = 0, Mandatory, HelpMessage = "Enter the user's Bluesky account name.")]
        [Alias('Handle')]
        [string]$AccountName
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
        $url = "https://bsky.social/xrpc/com.atproto.identity.resolveHandle?handle=$AccountName"
        _verbose -message ($strings.ResolveDID -f $AccountName)

        Try {
            $r = Invoke-RestMethod -Uri $url -ErrorAction Stop -ErrorVariable e
            $r.did
        }
        Catch {
            #convert the JSON error message
            $thisErr = $e.message | ConvertFrom-Json
            $errMsg = $strings.FailResolve -f $AccountName,$thisErr.message,$thisErr.error
            Write-Error $errMsg
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

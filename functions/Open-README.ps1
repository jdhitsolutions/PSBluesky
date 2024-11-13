Function Open-BskyHelp {
    [CmdletBinding()]
    [OutputType('None')]
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
        Try {
            $pdfPath = "$PSScriptRoot\..\PSBlueSky-Help.pdf"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS ] Attempting to open $pdfPath with the default PDF viewer."
            Invoke-Item -Path $pdfPath -ErrorAction Stop
        }
        Catch {
            Write-Warning "Failed to open the help file. ($_.Exception.Message)"
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
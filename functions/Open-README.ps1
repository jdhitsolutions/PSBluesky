Function Open-BskyHelp {
    [CmdletBinding()]
    [OutputType("None")]
    Param()

    Try {
        $pdfPath = "$PSScriptRoot\..\PSBlueSky-Help.pdf"
        Write-Verbose "Attempting to open $pdfPath with the default PDF viewer."
        Invoke-Item -Path $pdfPath -ErrorAction Stop
    }
    Catch {
        Write-Warning "Failed to open the help file. ($_.Exception.Message)"
    }
}
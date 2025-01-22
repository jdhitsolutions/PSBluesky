Function Add-BskyImage {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('PSBlueskyImageUpLoad')]
    param(
        [parameter(Position = 0, Mandatory, HelpMessage = 'The path to the image file.')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ },ErrorMessage = 'The file {0} could not be found.')]
        [ValidateScript({ (Get-Item $_).Length -lt 1MB }, ErrorMessage = 'The image file must be smaller than 1MB.')]
        [ValidatePattern('.*\.(jpg|jpeg|png|gif)$', ErrorMessage = 'The file must be a jpg, jpeg, or png file.')]
        [Alias('Path')]
        [string]$ImagePath,
        [Parameter(HelpMessage = 'You should include ALT text for the image.')]
        [Alias('Alt')]
        [string]$ImageAlt
    )

    Begin {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq "Runspace") {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }
        #Convert path to a file system path
        $ImagePath = Convert-Path -Path $ImagePath
        if ($script:BSkySession.accessJwt) {
            $token = $script:BSkySession.accessJwt

            $headers = @{
                Authorization = "Bearer $token"
            }
            Write-Information $script:BSkySession -Tags raw
        }
        else {
            Write-Warning $strings.NoSession
        }
    } #begin
    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"

        if ($headers) {
            $imageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
            _verbose -message ($strings.UploadImage -f $ImagePath, $ImageAlt)
            $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.uploadBlob"

            if ($PSCmdlet.ShouldProcess($ImagePath, 'Upload Bluesky image')) {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $imageBytes -ResponseHeadersVariable rh
                Write-Information -MessageData $rh -Tags ResponseHeader
                Write-Information -MessageData $response -Tags raws
                _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
                [PSCustomObject]@{
                    PSTypeName = 'PSBlueskyImageUpLoad'
                    Type       = $response.blob.'$type'
                    Link       = $response.blob.ref.'$link'
                    MimeType   = $response.blob.mimeType
                    Size       = $response.blob.size
                }
            } #WhatIf
        }
    } #process
    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        _verbose $strings.Ending
    } #end
}

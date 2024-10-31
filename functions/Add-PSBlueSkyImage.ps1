Function Add-BskyImage {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('PSCustomObject')]
    param(
        [parameter(Position = 0, Mandatory, HelpMessage = 'The path to the image file.')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [ValidatePattern('.*\.(jpg|jpeg|png|gif)$')]
        [Alias('Path')]
        [string]$ImagePath,
        [Parameter(HelpMessage = 'You should include ALT text for the image.')]
        [Alias('Alt')]
        [string]$ImageAlt,
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
        #Convert path to a file system path
        $ImagePath = Convert-Path -Path $ImagePath
        $token = Get-BskyAccessToken -Credential $Credential
    } #begin
    Process {
        if ($token) {
            $imageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Uploading image $ImagePath [$ImageAlt]"
            $uploadUrl = "$PDSHOST/xrpc/com.atproto.repo.uploadBlob"
            $headers = @{
                Authorization = "Bearer $token"
            }

            if ($PSCmdlet.ShouldProcess($ImagePath, 'Upload Bluesky image')) {
                $response = Invoke-RestMethod -Uri $uploadUrl -Method Post -Headers $headers -Body $imageBytes
                Write-Information -MessageData $response -Tags raws
                [PSCustomObject]@{
                    Type     = $response.blob.'$type'
                    Link     = $response.blob.ref.'$link'
                    MimeType = $response.blob.mimeType
                    Size     = $response.blob.size
                }
            }    #WhatIf
        }
        else {
            Write-Host 'Failed to authenticate.'
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}

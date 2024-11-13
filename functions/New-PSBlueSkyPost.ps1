# https://docs.bsky.app/docs/api/com-atproto-repo-create-record

Function New-BskyPost {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.String])]
    [Alias('skeet')]
    param(
        [parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The text of the post',
            ValueFromPipelineByPropertyName
            )]
        [ValidateNotNullOrEmpty()]
        [string]$Message,
        [parameter(HelpMessage = 'The path to the image file.',ValueFromPipelineByPropertyName)]
        [ValidatePattern('.*\.(jpg|jpeg|png|gif)$')]
        [string]$ImagePath,
        [Parameter(HelpMessage = 'You should include ALT text for the image.',ValueFromPipelineByPropertyName)]
        [Alias('Alt')]
        [string]$ImageAlt,
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running module version $ModuleVersion"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell version $($PSVersionTable.PSVersion)"
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running on $($PSVersionTable.OS)"
        }
        $token = Get-BskyAccessToken -Credential $Credential
    } #begin
    Process {
        If ($token) {
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }
            $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.createRecord"
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Posting message to $apiURL"

            $record = [ordered]@{
                '$type'   = 'app.bsky.feed.post'
                text      = $Message
                createdAt = (Get-Date -Format 'o')
            }

            #test message for links and mentions
            #test for @mentions first and update the text
            #Added 12 Nov 2024 Issue #14
            [regex]$rxMention = "@(?<name>[\w+-]*(\.[\w+-]+)+)"
            if ($rxMention.IsMatch($record.text)) {
                $matches = $rxMention.Matches($record.text)
                $matches | ForEach-Object {
                    #$_.Groups['name'].Value
                    $url = "https://bsky.app/profile/{0}" -f $_.Groups['name'].Value
                    $replace = "[$($_.value)]($url)"
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Replacing mention $($_.Value) with $replace"
                    $record.text = $record.text -replace $_.Value, $replace
                }
            }
            #test for Markdown style links
            #create a facet if found
            [regex]$pattern = "(?<text>(?<=\[)[^\]]+(?=\]))\]\((?<uri>http(s)?:\/\/\S+(?=\)))"
            #"(?<text>(?<=\[).*(?=\]))\]\((?<uri>http(s)?:\/\/\S+(?=\)))"
            if ($pattern.IsMatch($record.text)) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing Markdown style links"
                $matches = $pattern.Matches($record.text)
                #strip off the [ ] from text and the url from the message
                foreach ($match in $matches) {
                    $text = $match.Groups['text'].Value
                    $uri = $match.Groups['uri'].Value
                    #revise the text to be displayed
                    $record.text = ($record.text).replace("[$text]",$text).replace("($uri)","")
                }

                #now create the facets
                $facets = @()
                foreach ($match in $matches) {
                    $text = $match.Groups['text'].Value
                    $uri = $match.Groups['uri'].Value
                    $link = _newFacetLink -Text $text -Uri $uri -Message $record.text
                    $facets += $link
                }
                $record.Add('facets', $facets)
            }
            elseif (([regex]$pattern = 'http(s)?:\/\/\S+').IsMatch($Message)) {
                #a regex pattern to detect https or http links
                #1 Nov 2024 - made the regex more specific
                 Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing URL links"
                $matches = $pattern.Matches($Message)
                $facets = @()
                foreach ($match in $matches) {
                    $link = _newFacetLink -Text $match.Value -Uri $match.Value -Message $Message
                    $facets += $link
                }
                #$record.Add('langs', @('en'))
                $record.Add('facets', $facets)
            }

            if ($ImagePath) {
                if (-not $ImageAlt) {
                    Throw 'You must provide ALT text for the image.'
                }
                $image = Add-BskyImage -ImagePath $ImagePath -ImageAlt $ImageAlt -Credential $Credential
                Write-Information -MessageData $image -Tags raw
                if ($WhatIfPreference) {
                    #don't do anything
                }
                elseif ($image) {
                    $embed = @{
                        '$type' = 'app.bsky.embed.images'
                        images  = @(
                            @{
                                alt   = $ImageAlt
                                image = @{
                                    '$type'  = 'blob'
                                    ref      = @{'$link' = $image.link }
                                    mimeType = $image.mimeType
                                    size     = $image.size
                                }
                            }
                        )
                    }
                    $record.Add('embed', $embed)
                }
                else {
                    Throw "Failed to upload image $ImagePath. $($_.Exception.Message)"
                }
            }

            $body = @{
                repo       = $Credential.UserName
                collection = 'app.bsky.feed.post'
                record     = $record
            } | ConvertTo-Json -Depth 7

            Write-Information -MessageData $body -Tags raw

            if ($PSCmdlet.ShouldProcess($Message, 'Post to Bluesky')) {
                $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
                _convertAT -at $response.uri
                Write-Information -MessageData $response -Tags raw
            }
        }
        else {
            Write-Warning 'Failed to authenticate.'
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}

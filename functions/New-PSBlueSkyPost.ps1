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
        [Parameter(HelpMessage = 'The path to the image file.', ValueFromPipelineByPropertyName)]
        [ValidateScript({ Test-Path $_ },ErrorMessage = 'The file {0} could not be found.')]
        [ValidateScript({ (Get-Item $_).Length -lt 1MB }, ErrorMessage = 'The image file must be smaller than 1MB.')]
        [ValidatePattern('.*\.(jpg|jpeg|png)$', ErrorMessage = 'The file must be a jpg, jpeg, or png file.')]
        [string]$ImagePath,
        [Parameter(HelpMessage = 'You should include ALT text for the image.', ValueFromPipelineByPropertyName)]
        [Alias('Alt')]
        [string]$ImageAlt,
        [Parameter(HelpMessage = 'Label for an image e.g. sexual,nudity,porn. The label length must be between 3 and 128 characters.', ValueFromPipelineByPropertyName)]
        [AllowEmptyString()]
        [string]$Label
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

        $apiUrl = "$PDSHOST/xrpc/com.atproto.repo.createRecord"
        if ($script:BSkySession.accessJwt) {
            $token = $script:BSkySession.accessJwt
            $did = $script:BskySession.did
            $headers = @{
                Authorization  = "Bearer $token"
                'Content-Type' = 'application/json'
            }
            Write-Information $script:BSkySession -Tags raw
        }
        else {
            Write-Warning $strings.NoSession
        }
    } #begin
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        If ($headers) {
            _verbose $strings.PostMessage

            #Control characters will louse up spacing when we have hash tags, mentions, or links - replace any in message with space
            $Message = $Message -replace '\p{C}', ' '  #\p{C} is regex for 'unicode control chars'

            $record = [ordered]@{
                '$type'   = 'app.bsky.feed.post'
                text      = $Message
                createdAt = (Get-Date -Format 'o')
            }

            #now create the facets
            $facets = @()

            #test for Markdown style links first as this will affect the text
            #create a facet if found
            [regex]$pattern = '(?<text>(?<=\[)[^\]]+(?=\]))\]\((?<uri>http(s)?:\/\/\S+(?=\)))'
            #"(?<text>(?<=\[).*(?=\]))\]\((?<uri>http(s)?:\/\/\S+(?=\)))"
            if ($pattern.IsMatch($record.text)) {
                _verbose $string.ProcessMD
                $rxMatches = $pattern.Matches($record.text)
                #strip off the [ ] from text and the url from the message
                foreach ($match in $rxMatches) {
                    $text = $match.Groups['text'].Value
                    $uri = $match.Groups['uri'].Value
                    #revise the text to be displayed
                    $record.text = ($record.text).replace("[$text]", $text).replace("($uri)", '')
                }

                foreach ($match in $rxMatches) {
                    $text = $match.Groups['text'].Value
                    $uri = $match.Groups['uri'].Value
                    $link = _newFacetLink -Text $text -Uri $uri -Message $record.text -FacetType link
                    $facets += $link
                }
            }
            elseif (([regex]$pattern = 'http(s)?:\/\/\S+').IsMatch($Message)) {
                #a regex pattern to detect https or http links
                #1 Nov 2024 - made the regex more specific

                _verbose -message $string.ProcessUrl
                $rxMatches = $pattern.Matches($Message)
                #$facets = @()
                foreach ($match in $rxMatches) {
                    $link = _newFacetLink -Text $match.Value -Uri $match.Value -Message $Message
                    $facets += $link
                }
                #$record.Add('langs', @('en'))
            }

            #test for @mentions
            #Added 12 Nov 2024 Issue #14
            [regex]$rxMention = '(?<name>@[\w+-]*(\.[\w+-]+)+)'
            if ($rxMention.IsMatch($record.text)) {
                $rxMatches = $rxMention.Matches($record.text)
                $rxMatches | ForEach-Object {
                    #17 Nov 2024 Create a mention facet
                    #
                    <#
                    $url = "https://bsky.app/profile/{0}" -f $_.Groups['name'].Value
                    $replace = "[$($_.value)]($url)"
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Replacing mention $($_.Value) with $replace"
                    $record.text = $record.text -replace $_.Value, $replace
                    #>
                    $text = $_.Groups['name'].Value
                    _verbose -message ($strings.ResolveDID -f $text)
                    try {
                        $mentionDid = (Get-BskyProfile $text.SubString(1) -ErrorAction Stop ).did
                        $mention = _newFacetLink -Text $text -did $mentionDid -Message $record.text -FacetType mention
                        $facets += $mention
                    }
                    catch {Write-Warning "$Text did not match a user and will not be linked"}
                }
            }

            #test for tags
            [regex]$rxTag = '(?<tag>#[\w+-]+)'
            if ($rxTag.IsMatch($record.text)) {
                $rxMatches = $rxTag.Matches($record.text)
                $rxMatches | ForEach-Object {
                    $tag = $_.Groups['tag'].Value
                    $tagName = $tag.SubString(1)
                    $tagFacet = _newFacetLink -Text $tag -Message $record.text -FacetType tag -Tag $tagName
                    $facets += $tagFacet
                }
            } #if tags
            _verbose -message $strings.AddFacets
            $record.Add('facets', $facets)

            if ($ImagePath) {
                if (-not $ImageAlt) {
                    Throw $strings.MissingAlt
                }
                $image = Add-BskyImage -ImagePath $ImagePath -ImageAlt $ImageAlt
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
                    Throw ($strings.FailUpload -f $ImagePath, $_.Exception.Message)
                }
            }

            #Added from PR#23
            # https://atproto.blue/en/latest/atproto/atproto_client.models.com.atproto.label.defs.html
            <#
            "labels": {
                $type": "com.atproto.label.defs#selfLabels",
                "values": [
                    {"val": "nudity"},
                    ]
            }
                    #>
            _verbose -message ($strings.AddLabel -f $label)
            if ($label) {
                   $labels = @{
                       '$type'  = 'com.atproto.label.defs#selfLabels'
                       'values' = @( @{'val' = $label } )
                    }
                    $record.add('labels',$labels)
            }

            Write-Information -MessageData $record -Tags record
            #15 Nov 2024 Use the accounts DiD to post and not the user's handle
            $body = @{
                repo       = $did
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
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}

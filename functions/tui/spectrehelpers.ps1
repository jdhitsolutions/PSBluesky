$script:PreRequisitesPassed = $false

Function _testSpectreConsole {

    if ($script:PreRequisitesPassed) {
        return $true
    }

    # REQUIRES WINDOWS TERMINAL PREVIEW 1.22+ FOR SIXEL https://devblogs.microsoft.com/commandline/windows-terminal-preview-1-22-release/
    # Or another sixel capable terminal emulator but I've only tested on Windows Terminal Preview so far.
    
    $requiredVersion = [version]"2.1.2"
    
    $installed = Get-Module -ListAvailable -Name PwshSpectreConsole | Where-Object { $_.Version -ge $requiredVersion }
    if ($null -eq $installed) {
        Write-Host -ForegroundColor Yellow "This function requires the PwshSpectreConsole v$requiredVersion, do you want to install it from PSGallery now? [y/N]? " -NoNewline
        $response = Read-Host
        if ($response -eq "y") {
            Install-Module -Name PwshSpectreConsole -Scope CurrentUser -AllowPrerelease
            Import-Module -Name PwshSpectreConsole -Force
        } else {
            return $false
        }
    }

    if (-not (Test-SpectreSixelSupport)) {
        Write-Warning "This function requires a terminal emulator with sixel support. Please use Windows Terminal Preview 1.22+ or another terminal emulator with sixel support."
        return $false
    }

    $script:PreRequisitesPassed = $true
    return $true
}

Function _getSpectreFacetedMessage {
    <#
    .SYNOPSIS
        Get a message formatted with links in a spectre console compatible format.

    .DESCRIPTION
        Get a message formatted with links in a spectre console compatible format.
        This function is used to convert the raw message from the Bluesky API into a format that can be displayed in a console with links via spectre console.


    .PARAMETER Embed
        The raw embed object from the Bluesky API record.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(HelpMessage = 'The Bluesky message with the links')]
        [string]$Message,
        [Parameter(HelpMessage = 'The facets for the record')]
        [array]$Facets
    )

    Write-Verbose "[Helper] Getting the faceted message for '$Message'"

    if ([string]::IsNullOrEmpty($Message)) {
        return
    }

    # TODO the link byte-offsets won't be usable after escaping the text. Fix this later for messages with characters that need escaping
    if ($Message -ne ($Message | Get-SpectreEscapedText)) {
        return @(
            ("[Yellow]WARNING: Link expansion disabled because the text contains spectre formatting characters[/]" | Write-SpectreHost -PassThru),
            ($Message | Get-SpectreEscapedText)
        )
    }

    if ($null -eq $Facets -or $Facets.Count -eq 0) {
        return $Message | Get-SpectreEscapedText
    }
  
    $textWithFacets = [System.Collections.Generic.List[byte]] [System.Text.Encoding]::UTF8.GetBytes($Message)
    $facetsInReverseOrder = $Facets | Sort-Object @{ Expression = { $_.index.byteStart }; Descending = $true }
    $warnings = @()
    foreach ($facet in $facetsInReverseOrder) {
        try {
            $textWithFacets.InsertRange(
                $facet.index.byteEnd,
                [System.Text.Encoding]::UTF8.GetBytes("[/]"))

            $start = [System.Text.Encoding]::UTF8.GetBytes("[Red]")

            switch ($facet.features.'$type') {
                'app.bsky.richtext.facet#link' {
                    $start = [System.Text.Encoding]::UTF8.GetBytes("[DeepSkyBlue3_1 link=$($facet.features.uri)]")
                }
                'app.bsky.richtext.facet#tag' {
                    $start = [System.Text.Encoding]::UTF8.GetBytes("[DeepSkyBlue3_1 link=https://bsky.app/hashtag/$($facet.features.tag)]")
                }
                'app.bsky.richtext.facet#mention' {
                    $start = [System.Text.Encoding]::UTF8.GetBytes("[DeepSkyBlue3_1 link=https://bsky.app/profile/$($facet.features.did)]")
                }
                default {
                    $warnings += "[Yellow]WARNING: Unknown facet type ($($facet.features.'$type'))[/]"
                }
            }

            $textWithFacets.InsertRange($facet.index.byteStart, $start)

        }
        catch {
            $warnings += "[Yellow]WARNING: Failed to insert the facet at ($($facet.index.byteStart) -> $($facet.index.byteEnd))[/]"
        }
    }

    if ($warnings) {
        $textWithFacets.AddRange([System.Text.Encoding]::UTF8.GetBytes("`n" + ($warnings -join "`n")))
    }

    [System.Text.Encoding]::UTF8.GetString($textWithFacets)
}

Function _getSpectreMessageInlineImages {
    [CmdletBinding()]
    Param(
        [Parameter(HelpMessage = 'The image URLs to display')]
        [array]$Images,
        [Parameter(HelpMessage = 'The maximum width of the image')]
        [int]$ImageWidth = 30
    )

    $filteredImages = $Images | Where-Object { ![string]::IsNullOrEmpty($_) }
    if ($null -eq $filteredImages -or $filteredImages.Count -eq 0) {
        return
    }

    $postContentRows = @()
    try {
        # Display each image with an image link above and an image below it, display each in a column
        $postContentRows += $filteredImages | ForEach-Object {
            @(
                (Write-SpectreHost "[DeepSkyBlue3_1 link=$_]View Image :up_right_arrow:[/]" -PassThru),
                (Get-SpectreSixelImage $_ -MaxWidth $ImageWidth)
            ) | Format-SpectreRows
        } | Format-SpectreColumns
    }
    catch {
        $postContentRows += "Failed to load image: $_"
    }

    return $postContentRows
}

Function _getSpectreWebEmbed {
    [CmdletBinding()]
    Param(
        [Parameter(HelpMessage = 'The embed object to display')]
        [object]$Embed
    )
    if ($Embed.'$type' -eq 'app.bsky.embed.external#view') {
        $embedDescription = $Embed.external.description
        $embedUrl = $Embed.external.uri
        $embedTitle = ($Embed.external.title) ? ($Embed.external.title | Get-SpectreEscapedText) : $embedUrl
        $embedRows = @(
            "[DeepSkyBlue3_1 link=$embedUrl]$embedTitle :up_right_arrow:[/]"
        )
        if ($embedDescription -ne $Embed.external.title) {
            $embedRows += "[Grey69]$($embedDescription | Get-SpectreEscapedText)[/]"
        }
        return $embedRows | Format-SpectreRows
    }
}

Function _getEmbedThumbnails {
    <#
    .SYNOPSIS
        Get the thumbnail for the embed.

    .DESCRIPTION
        Get the thumbnail for the embed from various types.
        I haven't read the api spec and have just put together a couple of ones I've seen on my timeline so far.
        TODO This should be updated to return an embed object with a thumb, alt text and link property and should handle multiple embeds.

    .PARAMETER Embed
        The raw embed object from the Bluesky API record.
    #>
    Param(
        [object]$Embed
    )

    # TODO make detecting compatible embeds better than this
    $animatedEmbedUrls = @(
        '^https://media.tenor.com/.+',
        '^https://t.gifs.bsky.app/.+'
    )

    switch ($Embed.'$type') {
        'app.bsky.embed.images#view' {
            $Embed.images.thumb
        }
        'app.bsky.embed.external#view' {
            if ($animatedEmbedUrls | Where-Object { $Embed.external.uri -match $_ }) {
                $Embed.external.uri
            }
            else {
                $Embed.external.thumb
            }
        }
        'app.bsky.embed.video#view' {
            $Embed.thumbnail
        }
        'app.bsky.embed.recordWithMedia#view' {
            $Embed.media.external.thumb
        }
    }
}

function _removeBadEmoji {
    param (
        [Parameter(HelpMessage = 'The text to remove the bad emoji from text, they cause janky flickering', ValueFromPipeline = $true)]
        [string] $Text
    )

    return $Text -replace "(⚛️|❤️)", ""
}

function _formatSpectrePost {
    param (
        [object] $RawPost,
        [object] $Reason,
        [string] $Color = 'DeepSkyBlue3_1'
    )

    # Calculated properties for the post
    $uri = ($RawPost.uri -match '^at://.*') ? (_convertAT $RawPost.uri) : $RawPost.uri
    $text = $RawPost.record.text
    $images = @(_getEmbedThumbnails $RawPost.embed)
    $likes = $RawPost.likeCount
    $reposts = $RawPost.repostCount + $RawPost.quoteCount
    $replies = $RawPost.replyCount
    $date = $RawPost.record.createdAt.ToLocalTime()
    $facets = $RawPost.record.facets
    $reposted = $Reason.'$type' -eq "app.bsky.feed.defs#reasonRepost"
    $authorHandle = $RawPost.author.handle
    $author = Get-BskyProfile $authorHandle
    $authorName = $author.Display.Trim() | _removeBadEmoji | Get-SpectreEscapedText
    $avatarWidth = 10
    $avatarUrl = ([string]::IsNullOrEmpty($author.Avatar)) ? "$PSScriptRoot/../../images/fallback-avatar.png" : $author.Avatar
    $avatarImage = Get-SpectreSixelImage -ImagePath $avatarUrl -MaxWidth $avatarWidth

    # Formatted strings for the post
    $likesFormat = ":red_heart:  [red]$likes[/]"
    $repostsFormat = ":repeat_button: [white]$reposts[/]"
    $repliesFormat = ":speech_balloon: [white]$replies[/]"
    $authorNameFormat = "[white]$authorName[/]"
    $authorLinkFormat = "[grey69 link=$Uri]@$authorHandle[/]"
    $postDateFormat = "[grey42]$date[/]"
   
    # Post components
    $postMessageRows = @()

    $postMessageRows += Write-SpectreHost "" -PassThru

    $postText = _getSpectreFacetedMessage -Message $Text -Facets $Facets | _removeBadEmoji | Write-SpectreHost -PassThru | Format-SpectrePadded -Top 0 -Bottom 1 -Left 0 -Right 0
    if (![string]::IsNullOrWhiteSpace($postText)) {
        $postMessageRows += $postText
    }
    
    # If the post has quoted post embed it
    $hasQuotedPost = $RawPost.embed.'$type' -eq 'app.bsky.embed.record#view'
    if ($hasQuotedPost) {
        $quotedAuthorHandle = $RawPost.embed.record.author.handle
        $quotedUri = ($RawPost.embed.record.uri -match '^at://.*') ? (_convertAT $RawPost.embed.record.uri) : $RawPost.embed.record.uri
        $quotedTitle = "[Grey30] Quoting [link=$quotedUri]@$quotedAuthorHandle[/] [/]"
        $quotedRawText = ([string]::IsNullOrEmpty($RawPost.embed.record.value.text) ? "Post has no text" : $RawPost.embed.record.value.text) | Get-SpectreEscapedText
        $quotedText = ($RawPost.embed.record.notFound -eq $true) ? "Deleted post" : $quotedRawText
        if ($RawPost.embed.record.record.'$type' -eq "app.bsky.graph.starterpack") {
            $quotedText = "Starter Pack [DeepSkyBlue3_1 link=$($RawPost.embed.record.uri)]$($RawPost.embed.record.record.name | Get-SpectreEscapedText) :up_right_arrow:[/]"
        }
        
        $postMessageRows += $quotedText | _removeBadEmoji | Format-SpectrePadded -Padding 1 | Format-SpectrePanel -Color Grey30 -Title $quotedTitle | Format-SpectrePadded -Top 0 -Bottom 1 -Left 0 -Right 0
    }

    $webEmbed = _getSpectreWebEmbed -Embed $RawPost.embed
    if ($webEmbed) {
        $postMessageRows += $webEmbed | Format-SpectrePadded -Top 0 -Bottom 1 -Left 0 -Right 0
    }

    $inlineImages = _getSpectreMessageInlineImages -Images $images
    if ($inlineImages) {
        $postMessageRows += $inlineImages | Format-SpectrePadded -Top 0 -Bottom 1 -Left 0 -Right 0
    }
  
    # Format the post as a grid with the avatar on the left and the content on the right
    $postMessage = $postMessageRows | Format-SpectreRows
    $avatarPanel = $avatarImage | Format-SpectrePanel -Width $avatarWidth -Border None | Format-SpectrePadded -Top 1 -Bottom 0 -Left 0 -Right 0
    $postPanelContent = New-SpectreGridRow -Data @($avatarPanel, $postMessage) | Format-SpectreGrid -Padding 0
  
    # Clamp the height of the post to be at least 9 lines high or larger if the content requires it
    $renderableHeight = ($postPanelContent | Format-SpectrePanel | Get-SpectreRenderableSize).Height
    $postPanelHeight = [Math]::Max(9, $renderableHeight)
  
    # The main post panel
    $postTitle = "[white] $authorNameFormat $authorLinkFormat $likesFormat $repostsFormat $repliesFormat $postDateFormat [/]"
    $formattedPanelPost = $postPanelContent | Format-SpectrePanel -Title $postTitle -Color $Color -Height $postPanelHeight -Expand

    # If the post was reposted, wrap it in a panel with a "reposted by" message
    if ($reposted) {
        $repostTitle = "[DeepSkyBlue3_1] :repeat_button: Reposted by [link=https://bsky.app/profile/$($reason.by.did)]@$($reason.by.handle)[/] [/]"
        $formattedPanelPost = $formattedPanelPost | Format-SpectrePadded -Padding 1 | Format-SpectrePanel -Color $Color -Height ($postPanelHeight + 4) -Title $repostTitle -Expand
    }
  
    return $formattedPanelPost
}
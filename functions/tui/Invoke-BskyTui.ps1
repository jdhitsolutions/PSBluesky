Function Invoke-BskyTui {
  param (
    [int] $Limit = 25
  )

  # Figure out if this terminal can run the UI
  if (-not (_testSpectreConsole)) {
    Write-Warning "Invoke-BskyTui requires PwshSpectreConsole Prerelease and a terminal emulator with sixel support."
    return
  }

  # Fail early if there is no auth session
  if ($null -eq $script:BSkySession.accessJwt) {
    Write-Warning $strings.NoSession
    return
  }

  # Load the timeline
  $timeline = Invoke-SpectreCommandWithStatus -Spinner BouncingBall -Title "Loading BlueSky Timeline..." -Color DeepSkyBlue3_1 -ScriptBlock {
    Get-BskyTimeline -Limit $Limit -Raw
  }
  
  # Build the timeline
  $formattedPosts = Invoke-SpectreCommandWithStatus -Spinner BouncingBall -Title "Loading BlueSky Posts..." -Color DeepSkyBlue3_1 -ScriptBlock {
    foreach ($post in $timeline) {
      Write-SpectreHost "[Grey69]Formatting post $($post.post.uri)[/]"

      if ($post.post.blocked -or $post.reply.root.blocked -or $post.reply.parent.blocked) {
        Write-SpectreHost "[Grey69]Post is blocked, skipping[/]"
        continue
      }

      if ($post.post.notFound -or $post.reply.root.notFound -or $post.reply.parent.notFound) {
        Write-SpectreHost "[Grey69]Post not found, skipping[/]"
        continue
      }
  
      $postTextWithoutEmoji = (($post.post.record.text -replace '[\p{So}\p{Cs}]', '') -ne $post.post.record.text) ? "..." : $post.post.record.text
  
      $formattedPost = _formatSpectrePost -RawPost $post.post -Reason $post.reason
    
      if ($null -eq $post.reply) {
        @{
          Summary = "[Grey15]$($postTextWithoutEmoji + " " | Get-SpectreEscapedText)[/]" | Format-SpectrePanel -Height 3 -Expand -Header "[Grey15]$($post.post.author.handle) - $($post.post.record.createdAt.ToLocalTime())[/]" -Color Grey15
          ReplyTo = _getReplyTo $post
          Tree = $formattedPost
        }
        continue
      }
    
      # If this post is a reply, format the parent post and add it as a child to make it look threaded
      $children = @()
        
      if ($null -ne $post.reply.parent.record -and $post.reply.parent.uri -ne $post.reply.root.uri) {
        $formattedParent = _formatSpectrePost -RawPost $post.reply.parent -Color Grey30
        $children += @{
          Value = $formattedParent
          Children = @(
            @{
              Value = $formattedPost
            }
          )
        }
      } else {
        $children += @{
          Value = $formattedPost
        }
      }
  
      @{
        Summary = "[Grey15]$($postTextWithoutEmoji + " " | Get-SpectreEscapedText)[/]" | Format-SpectrePanel -Height 3 -Expand -Header "[Grey15]$($post.post.author.handle) - $($post.post.record.createdAt.ToLocalTime())[/]" -Color Grey15
        ReplyTo = _getReplyTo $post
        Tree = @{
          Value = _formatSpectrePost -RawPost $post.reply.root -Color Grey30
          Children = @($children)
        } | Format-SpectreTree -Guide Line -Color Grey30
      }
    }
  }
  
  # Build the layout
  $replyInput = New-SpectreLayout -Data "" -MinimumSize 4 -Name "reply" -Ratio 1
  $replyInput.IsVisible = $false
  $rootLayout = New-SpectreLayout -Name "root" -Rows @(
    (New-SpectreLayout -Data (_uiHeader) -Name "header" -MinimumSize 2 -Ratio 1),
    (New-SpectreLayout -Data "Loading BlueSky Timeline..." -Name "timeline" -Ratio 1000),
    $replyInput,
    (New-SpectreLayout -Data (_uiControls -CurrentIndex 0 -TotalPosts $formattedPosts.Count) -Name "controls" -MinimumSize 5 -Ratio 1)
  )
  
  # Start the UI loop
  Invoke-SpectreLive -Data $rootLayout -ScriptBlock {
    param (
      $Context
    )
    
    $currentIndex = 0
  
    while ($true) {
      $currentPost = $formattedPosts | Select-Object -Skip $currentIndex -First 1 -ExpandProperty Tree
      $remainingPostSummaries = $formattedPosts | Select-Object -Skip ($currentIndex + 1) -ExpandProperty Summary
  
      $rootLayout["header"].Update((_uiHeader))
      $rootLayout["timeline"].Update((@($currentPost) + $remainingPostSummaries | Format-SpectreRows))
      $rootLayout["controls"].Update((_uiControls -CurrentIndex $currentIndex -TotalPosts $formattedPosts.Count))
      $Context.Refresh()
      
      if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "DownArrow" -and $currentIndex -lt ($formattedPosts.Count - 1)) {
          $currentIndex += 1
          $rootLayout["timeline"].Update((" " | Write-SpectreHost -PassThru));
          $Context.Refresh()
        } elseif ($key.Key -eq "UpArrow" -and $currentIndex -gt 0) {
          $currentIndex -= 1
          $rootLayout["timeline"].Update((" " | Write-SpectreHost -PassThru));
          $Context.Refresh()
        } elseif ($key.Key -eq "r") {
          _uiReplyHandler -CurrentIndex $currentIndex -FormattedPosts $formattedPosts -Layout $rootLayout -Context $Context
        }
      } else {
        Start-Sleep -Milliseconds 50
      }
    }
  }
}
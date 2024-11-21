# The UI components are just functions that return a spectre renderable given some input

function _uiHeader {
  return "[white on DeepSkyBlue3_1] PSBluesky $(" " * ($Host.UI.RawUI.WindowSize.Width - 11))[/]" | Write-SpectreHost -PassThru
}

function _uiControls {
  param (
    [int] $CurrentIndex,
    [int] $TotalPosts,
    [switch] $Replying
  )
  $color = "DeepSkyBlue3_1"
  $controls = "[white on DeepSkyBlue3_1] :down_arrow: [/] Next Post`n[white on DeepSkyBlue3_1] :up_arrow: [/] Previous Post`n[white on DeepSkyBlue3_1] r [/] Reply"

  if ($Replying) {
    $color = "Grey30"
    $controls = "Replying to Post...`n`n[white on DeepSkyBlue3_1] Esc          [/] Cancel Reply`n[white on DeepSkyBlue3_1] Ctrl + Enter [/] Post Reply"
  }
  
  return $controls | Format-SpectrePanel -Title "Controls" -Color $color -Expand
}

function _uiTextEntry {
  param (
    [string] $TextInput
  )

  # Put a block char at the end of the input to show the cursor
  $TextInput + "█" | Get-SpectreEscapedText | Format-SpectrePanel -Header "Reply" -Color DeepSkyBlue3_1 -Expand
}

Function _uiReplyLoop {
  param (
    [int] $CurrentIndex,
    [string] $CurrentInput,
    [array] $FormattedPosts,
    [Spectre.Console.Layout] $Layout,
    [Spectre.Console.LiveDisplayContext] $Context
  )

  $Layout["controls"].Update((_uiControls -CurrentIndex $CurrentIndex -TotalPosts $FormattedPosts.Count -Replying))
  $Layout["reply"].IsVisible = $true
  $Layout["reply"].Update((_uiTextEntry -TextInput ""))
  $Context.Refresh()

  $currentInput = ""

  while ($true) {
    if ([Console]::KeyAvailable) {
      $key = [Console]::ReadKey($true)
      if ($key.Key -eq "Enter" -and $key.Modifiers -eq "Control") {
        $Layout["reply"].Update((_uiTextEntry -TextInput "SENDING REPLY"))
        $Layout["controls"].Update((_uiControls -CurrentIndex $CurrentIndex -TotalPosts $FormattedPosts.Count))
        break
      } elseif ($key.Key -eq "Escape") {
        $Layout["reply"].Update((_uiTextEntry -TextInput "EXITING REPLY"))
        $Layout["controls"].Update((_uiControls -CurrentIndex $CurrentIndex -TotalPosts $FormattedPosts.Count))
        break
      } elseif ($key.Key -eq "Backspace") {
          # Remove the last character from the current input string
          $currentInput = $currentInput.Substring(0, [Math]::Max(0, $currentInput.Length - 1))
      } elseif ($key.Key -eq "Enter") {
          # Add a newline to the current input string
          $currentInput += "`n"
      } elseif ($key.KeyChar) {
          # Add the character to the current input string
          $currentInput += $key.KeyChar
      }
    }
    $Layout["reply"].Update((_uiTextEntry -TextInput $currentInput))
    $Layout["reply"].MinimumSize = $currentInput.Split("`n").Count + 3
    $Context.Refresh()
  }

  $Context.Refresh()
  $Layout["reply"].IsVisible = $false
  $Context.Refresh()
}
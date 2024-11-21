# The UI handlers are functions that handle some input

Function _uiReplyHandler {
  param (
    [int] $CurrentIndex,
    [array] $FormattedPosts,
    [Spectre.Console.Layout] $Layout,
    [Spectre.Console.LiveDisplayContext] $Context
  )

  $replyTo = $FormattedPosts | Select-Object -Skip $CurrentIndex -First 1 -ExpandProperty ReplyTo

  $Layout["controls"].Update((_uiControls -CurrentIndex $CurrentIndex -TotalPosts $FormattedPosts.Count -Replying))
  $Layout["controls"].MinimumSize = 6
  $Layout["reply"].IsVisible = $true
  $Layout["reply"].Update((_uiTextEntry -TextInput ""))
  $Context.Refresh()

  $currentInput = ""

  while ($true) {
    if ([Console]::KeyAvailable) {
      $key = [Console]::ReadKey($true)
      if ($key.Key -eq "Enter" -and $key.Modifiers -eq "Control") {
        $Layout["reply"].Update((_uiTextEntry -TextInput "SENDING REPLY: $($replyTo | ConvertTo-Json -Depth 25 -Compress)"))
        $Layout["controls"].Update((_uiControls -CurrentIndex $CurrentIndex -TotalPosts $FormattedPosts.Count))
        $null = New-BskyPost -Message $currentInput -ReplyTo $replyTo
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
  Start-Sleep -Seconds 5
  $Layout["reply"].IsVisible = $false
  $Layout["controls"].MinimumSize = 5
  $Context.Refresh()
}
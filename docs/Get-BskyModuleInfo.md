---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskymoduleinfo
schema: 2.0.0
---

# Get-BskyModuleInfo

## SYNOPSIS

Get a summary of the PSBlueSky module.

## SYNTAX

```yaml
Get-BskyModuleInfo [<CommonParameters>]
```

## DESCRIPTION

Use this command to get a summary of the PSBlueSky module showing functions, aliases and a help synopsis. The default output includes clickable links to online command help and the module's GitHub repository.

## EXAMPLES

### Example 1

```text
PS C:\> Get-BskyModuleInfo

   Module: PSBlueSky [v2.4.0]

Name                      Alias               Synopsis
----                      -----               --------
Add-BskyImage                                 Upload an image to Bluesky.
Block-BskyUser                                Block a Bluesky user account.
Disable-BskyLogging                           Disable BlueSky API logging.
Enable-BskyLogging                            Enable BlueSky API logging.
Export-BskyPreference                         Export your PSBlueSky format...
Find-BskyUser             bsu                 Search for Bluesky user accou...
Get-BskyAccountDID                            Resolve a Bluesky account nam...
Get-BskyBlockedList       bsblocklist         Get your subscribed blocked l...
Get-BskyBlockedUser       bsblock             Get your blocked accounts.
Get-BskyFeed              bsfeed              Get your Bluesky feed.
Get-BskyFollowers         bsfollower          Get your Bluesky followers
Get-BskyFollowing         bsfollow            Get a list of Bluesky accounts...
Get-BskyLiked             bsliked             Get your liked Bluesky posts.
Get-BskyLogging                               Getting the current PSBlueSky ...
Get-BskyModuleInfo                            Get a summary of the PSBlueSky...
Get-BskyNotification      bsn                 Get Bluesky notifications.
Get-BskyPreference                            Get PSBlueSky formatting prefe...
Get-BskyProfile           bsp                 Get a Bluesky profile.
Get-BskySession           bss                 Show your current Bluesky session.
Get-BskyTimeline          bst                 Get your Bluesky timeline.
New-BskyFollow            Follow-BskyUser     Follow a Bluesky user.
New-BskyPost              skeet               Create a Bluesky post.
Open-BskyHelp             bshelp              Open the PSBluesky help document.
Publish-BskyPost          Repost-BskyPost     Repost or quote a Bluesky post.
Remove-BskyFollow         Unfollow-BskyUser   Unfollow a Bluesky user.
Remove-BskyPreferenceFile                     Delete the user's PSBlueSky pre...
Set-BskyLogging                               Configure PSBlueSky API logging.
Set-BskyPreference                            Set a PSBlueSky formatting pref...
Start-BSkySession                             Start a new Bluesky session.
Unblock-BskyUser                              Unblock a Bluesky user account.
Update-BskySession        Refresh-BskySession Refresh the Bluesky session token.
```

The default output includes clickable hyperlinks to th online help for each command in the module's GitHub repository.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyModuleInfo

## NOTES

## RELATED LINKS

[Get-BskyPreference](Get-BskyPreference.md)

[Open-BskyHelp](Open-BskyHelp.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/publishbskypost
schema: 2.0.0
---

# Publish-BskyPost

## SYNOPSIS

Repost or quote a Bluesky post.

## SYNTAX

```yaml
Publish-BskyPost [-Uri] <String> [-CID] <String> [[-Quote] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

You can use the command to repost or quote a Bluesky post. The default action will be a repost unless you specify the -Quote parameter. The command requires URI and CID values from the post you want to quote or repost. These values are part of the output from commands like Get-BskyFeed and Get-BskyTimeline. The easiest way is to pipe an object to this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> $tl[-1] | Publish-BskyPost -Verbose -WhatIf
VERBOSE: [12:14:47:7437 BEGIN  ] Publish-BskyPost->  Starting PSBluesky module command
VERBOSE: [12:14:47:7440 BEGIN  ] Publish-BskyPost->  Running under PowerShell version 7.4.6
VERBOSE: [12:14:47:7442 BEGIN  ] Publish-BskyPost->  Using PowerShell Host ConsoleHost
VERBOSE: [12:14:47:7464 BEGIN  ] Publish-BskyPost->  Running under Operating System Microsoft Windows 10.0.26100
VERBOSE: [12:14:47:7466 BEGIN  ] Publish-BskyPost->  Using module PSBluesky version 2.2.0
VERBOSE: [12:14:47:7470 PROCESS] Publish-BskyPost->  Reposting the message with AT Uri at://did:plc:nsy2e4vupxndly4adhszebcy/app.bsky.feed.post/3lfbhddas6s25
What if: Performing the operation "Publish to Bluesky" on target "at://did:plc:nsy2e4vupxndly4adhszebcy/app.bsky.feed.post/3lfbhddas6s25".
VERBOSE: [12:14:47:7476 END    ] Publish-BskyPost->  Ending PSBluesky module command
```

This example assumes that $tl is a collection of PSBlueskyTimelinePost objects. Because no quote was provided this example would have the effect of reposting the last post in the timeline array.

### Example 2

```powershell
PS C:\> $f[-4] | Publish-BskyPost -Quote "I couldn't agree more." -Verbose -WhatIf
VERBOSE: [12:25:49:9364 BEGIN  ] Publish-BskyPost->  Starting PSBluesky module command
VERBOSE: [12:25:49:9366 BEGIN  ] Publish-BskyPost->  Running under PowerShell version 7.4.6
VERBOSE: [12:25:49:9368 BEGIN  ] Publish-BskyPost->  Using PowerShell Host ConsoleHost
VERBOSE: [12:25:49:9370 BEGIN  ] Publish-BskyPost->  Running under Operating System Microsoft Windows 10.0.26100
VERBOSE: [12:25:49:9372 BEGIN  ] Publish-BskyPost->  Using module PSBluesky version 2.2.0
VERBOSE: [12:25:49:9376 PROCESS] Publish-BskyPost->  Quoting the message with AT Uri at://did:plc:ohgsqpfsbocaaxusxqlgfvd7/app.bsky.feed.post/3lfb2rervzy2g
What if: Performing the operation "Publish to Bluesky" on target "at://did:plc:ohgsqpfsbocaaxusxqlgfvd7/app.bsky.feed.post/3lfb2rervzy2g".
VERBOSE: [12:25:49:9381 END    ] Publish-BskyPost->  Ending PSBluesky module command
```

Quoting a PSBlueskyFeedItem.

## PARAMETERS

### -CID

The Bluesky post CID which will look like bafyreihsbxv5p3zckgocz43tpjuzn5e77wpp2ynsqtuv6blwioyjc3bzee

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Quote

Add quoted text.
Otherwise the result will be a simple repost.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri

The Bluesky post AT Uri which will look like at://did:plc:ohgsqpfsbocaaxusxqlgfvd7/app.bsky.feed.post/3lfb2rervzy2g

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyTimeline](Get-BskyTimeline.md)

[Get-BskyFeed](Get-BskyFeed.md)

[Get-BskyNotification](Get-BskyNotification.md)

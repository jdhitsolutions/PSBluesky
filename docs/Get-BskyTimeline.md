---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyTimeline

## SYNOPSIS

Get your Bluesky timeline

## SYNTAX

```yaml
Get-BskyTimeline [[-Limit] <Int32>] [-Credential] <PSCredential>
 [<CommonParameters>]
```

## DESCRIPTION

This command will return all items on your Bluesky timeline. The items are based on the credential you use to authenticate.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyTimeline -limit 10

Date                Author                       Liked Reposted Quoted Text
----                ------                       ----- -------- ------ ----
10/27/2024 1:05 PM  jamelle                      1     0        0      fair enough
...
```

The text should be a clickable link that will open the timeline item. This example assumes the credential has been set in $PSDefaultParameterValues.

## PARAMETERS

### -Credential

A PSCredential with your Bluesky username and password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit

Enter the number of timeline posts to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyTimelinePost

## NOTES

## RELATED LINKS

[Get-BskyFeed](Get-BskyFeed.md)

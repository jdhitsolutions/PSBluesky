---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyFeed

## SYNOPSIS

Get your Bluesky feed.

## SYNTAX

```yaml
Get-BskyFeed [[-Limit] <Int32>] [-Credential] <PSCredential>
 [<CommonParameters>]
```

## DESCRIPTION

This command will return your posts and replies. The default output should feature clickable links. You can get between 1 and 100 feed items. The default is 50.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyFeed -Limit 3

Jeff Hicks [jdhitsolutions.com]

I'm using the #PowerShell InformationVariable to store the raw response from
the Bluesky API.

Date                   Liked Replied Reposted Quoted
----                   ----- ------- -------- ------
10/27/2024 12:05:15 PM     1       0        0      0


Jeff Hicks [jdhitsolutions.com]

Added a #PowerShell command to get items you've posted to your feed.

Date                   Liked Replied Reposted Quoted
----                   ----- ------- -------- ------
10/27/2024 11:49:25 AM     1       0        0      0


Jeff Hicks [jdhitsolutions.com]

Adding a Get-BskyFollowers command to my #PowerShell module.

Date                  Liked Replied Reposted Quoted
----                  ----- ------- -------- ------
10/27/2024 9:54:53 AM     3       0        0      0
```

The default is 50 feed items. The default output includes clickable links. This example assumes the credential has been set in $PSDefaultParameterValues.

## PARAMETERS

### -Credential

A PSCredential with your Bluesky username and password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit

Enter the number of accounts that you follow to retrieve between 1 and 100.
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

### PSBlueskyFeedItem

## NOTES

## RELATED LINKS

[Get-BskyTimeline](Get-BskyTimeline.md)


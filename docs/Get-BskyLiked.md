---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyLiked

## SYNOPSIS

Get your liked Bluesky posts.

## SYNTAX

### Limit

```yaml
Get-BskyLiked [-Limit <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyLiked [-All] [<CommonParameters>]
```

## DESCRIPTION

Get your liked Bluesky posts. The default behavior is to get the 50 most recent liked posts. You can use the -Limit parameter to specify the number of liked posts to retrieve. The maximum number of liked posts you can retrieve is 100. Or use -All to retrieve all liked posts.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyLiked -limit 1

April Yoho [theaprilyoho.dev]

Out on a walk with #SirTitan today. Three weeks of being sick has kept us from our usual jaunts.

Goodbye 2024 💪👏

Date                  Liked Replied Reposted Quoted
----                  ----- ------- -------- ------
12/31/2024 4:24:06 PM    17       1        0      0
```

The default formatted output uses ANSI escape sequences and includes clickable links.

## PARAMETERS

### -All

Return all liked posts

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit

Enter the number of liked posts to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: Limit
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyLikedItem

## NOTES

## RELATED LINKS

[Get-BskyFeed](Get-BskyFeed.md)

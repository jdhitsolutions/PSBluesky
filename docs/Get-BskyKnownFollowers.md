---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/6eb30b
schema: 2.0.0
---

# Get-BskyKnownFollowers

## SYNOPSIS

Get known Bluesky followers

## SYNTAX

### Limit (Default)

```yaml
Get-BskyKnownFollowers [[-Limit] <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyKnownFollowers [-All] [<CommonParameters>]
```

## DESCRIPTION

This command will return a list of your Bluesky followers that you follow back, You can get between 1 and 100. The default is 50. Or use the All parameter to page through all followers.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyKnownFollowers -All

Display                                Username                     Description
-------                                --------                     -----------
Pwnallthethings                        pwnallthethings.bsky.social  Just thinking out loud.
Dan Wahlin                             danwahlin.bsky.social        Cloud Developer Advocate (Azure,
                                                                    AI, JS/TS, more) | Microsoft
                                                                    Pluralsight Author |
                                                                    codewithdan.me/ps-author
,,,
```

## PARAMETERS

### -All

Return All followers

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

Enter the number of followers to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: Limit
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

### PSBlueskyFollowProfile

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyFollowers](Get-BskyFollowers.md)

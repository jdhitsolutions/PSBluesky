---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyFollowers

## SYNOPSIS

Get your Bluesky followers.

## SYNTAX

### Limit (Default)

```yaml
Get-BskyFollowers [[-Limit] <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyFollowers [-All] [<CommonParameters>]
```

## DESCRIPTION

This command will return a list of your Bluesky followers, You can get between 1 and 100. The default is 50. Or use the All parameter to page through all followers.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyFollowers -Limit 2

Display       Username           Description
-------       --------           -----------
Jonathan Lank jpluk.bsky.social
Libby Brown   trubludevil.social Product manager @ SpruceID. Mom. Digital
                                 Wallet and Passkey enthusiast. Duke fan.
                                 Dweller of Seattle exurbia.
```

The default output includes clickable links.

## PARAMETERS

### -Limit

Enter the number of followers to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: Limit
Aliases:

Required: False
Position: 0
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyFollowProfile

## NOTES

## RELATED LINKS

[Get-BskyFollowing](Get-BskyFollowing.md)

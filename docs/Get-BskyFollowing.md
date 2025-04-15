---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskyfollowing
schema: 2.0.0
---

# Get-BskyFollowing

## SYNOPSIS

Get a list of Bluesky accounts that you follow.

## SYNTAX

### Limit (Default)

```yaml
Get-BskyFollowing [[-Limit] <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyFollowing [-All] [<CommonParameters>]
```

## DESCRIPTION

This command will return a list of Bluesky accounts that you follow. You can get between 1 and 100. The default is 50. Or use -All to get all accounts that you follow.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyFollowing -Limit 2

Display      Username                   Description
-------      --------                   -----------
Lou Creemers lovelacecoding.bsky.social Microsoft MVP | ❤️ .NET | Uni teacher |
                                        Board member of the .NET Foundation 💜
                                        | Proud dad joke lover
             mikeshepard70.bsky.social
```

The default output includes clickable links to the user's profile.

## PARAMETERS

### -Limit

Enter the number of accounts that you follow to retrieve between 1 and 100.
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

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyFollowers](Get-BskyFollowers.md)

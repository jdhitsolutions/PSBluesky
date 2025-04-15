---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskyblockedlist
schema: 2.0.0
---

# Get-BskyBlockedList

## SYNOPSIS

Get your subscribed blocked lists.

## SYNTAX

### Limit (Default)

```yaml
Get-BskyBlockedList [[-Limit] <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyBlockedList [-All] [<CommonParameters>]
```

## DESCRIPTION

Get a list of the blocked lists you have subscribed to in Bluesky. These aren't lists that you have blocked, but lists that contain accounts that you end up blocked.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyBlockedList

Name        : Scammers (catfish, crypto, etc.)
Purpose     : Moderated list
Labels      :
Items       : 33
CreatedBy   : mkaney.bsky.social
Indexed     : 12/2/2024 9:50:00 PM
Description : catfish, crypto, etc.
```

The default output includes clickable hyperlinks.

## PARAMETERS

### -All

Return all blocked lists

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

Enter the number of blocked lists to retrieve between 1 and 100.
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

### PSBlueskyBlockedList

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyBlockedUser](Get-BskyBlockedUser.md)

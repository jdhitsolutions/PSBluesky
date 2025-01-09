---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyBlockedUser

## SYNOPSIS

Get your blocked accounts

## SYNTAX

### Limit (Default)

```yaml
Get-BskyBlockedUser [[-Limit] <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyBlockedUser [-All] [<CommonParameters>]
```

## DESCRIPTION

Use this command to list user accounts that you have blocked in Bluesky.

## EXAMPLES

### Example 1

```powershell
PS C:\>  Get-BskyBlockedUser

Display                     Username            Labels Description
-------                     --------            ----- -----------
stormy373.bsky.social       stormy.bsky.social  porn   I offer a wide range...
```

This is a sample blocked user account. The default formatting includes clickable hyperlinks.

## PARAMETERS

### -All
Return all blocked accounts

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

Enter the number of blocked accounts to retrieve between 1 and 100.
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

### PSBlueskyBlockedUser

## NOTES

## RELATED LINKS

[Get-BskyBlockedList](Get-BskyBlockedList.md)

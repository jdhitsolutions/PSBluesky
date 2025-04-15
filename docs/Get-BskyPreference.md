---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskypreference
schema: 2.0.0
---

# Get-BskyPreference

## SYNOPSIS

Get PSBlueSky formatting preference settings.

## SYNTAX

```yaml
Get-BskyPreference [[-Setting] <String>] [<CommonParameters>]
```

## DESCRIPTION

The PSBluesky module uses custom formatting files that rely on ANSI sequences to format output. In earlier versions of the module, these values were hard-coded in the format file. Now, these values are stored in hash table preference variable called $bskyPreference. However, rather than managing the variable directly, you should use the preference commands in the PSBluesky module.

This command and the bskyPreference variable were introduced in PSBluesky v2.3.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyPreference

Setting              Style
-------              -----
Username             `e[4;38;5;190m
ProfileDescription   `e[3;96m
Message              `e[3;93m
BlockedList          `e[4;92m
IsRepost             `e[36m
LikedLow             `e[38;5;48m
LikedMedium          `e[38;5;214m
LikedHigh            `e[38;5;105m
LikedHighest         `e[38;5;201m
InfoAlias            `e[3;38;5;220m
ActiveSession        `e[92m
InActiveSession      `e[91m
Add-BskyImage        `e[1;38;5;122m
Find-BskyUser        `e[1;38;5;111m
Get-BskyFeed         `e[1;96m
Get-BskyBlockedList  `e[1;38;5;165m
Get-BskyBlockedUser  `e[1;38;5;168m
Get-BskyFollowers    `e[1;38;5;182m
Get-BskyFollowing    `e[1;38;5;208m
Get-BskyLiked        `e[1;38;5;201m
Get-BskyNotification `e[1;38;5;195m
Get-BskyProfile      `e[1;38;5;214m
Get-BskySession      `e[1;38;5;197m
New-BskyFollow       `e[1;38;5;199m
New-BskyPost         `e[1;38;5;159m
Publish-BskyPost     `e[1;38;5;180m
Remove-BskyFollow    `e[1;95m
Start-BskySession    `e[1;38;5;228m
DefaultCommand       `e[1;38;5;51m
```

The default output is listing all the preference settings and their values. The Style shows the ANSI sequence for each setting formatted with that sequence.

### Example 2

```powershell
PS C:\> Get-BskyPreference Username

Setting  Style
-------  -----
Username `e[4;38;5;190m
```

Get a single preference setting.

## PARAMETERS

### -Setting

Specify a preference setting.

```yaml
Type: String
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

### BskyPreference

## NOTES

## RELATED LINKS

[Set-BskyPreference](Set-BskyPreference.md)

[Export-BskyPreference](Export-BskyPreference.md)

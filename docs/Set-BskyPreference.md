---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/setbskypreference
schema: 2.0.0
---

# Set-BskyPreference

## SYNOPSIS

Set a PSBlueSky formatting preference.

## SYNTAX

```yaml
Set-BskyPreference [-Setting] <String> [-Style <String>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Instead of updating the $bskyPreference variable directly, use the Set-BskyPreference command to change preference settings. The change is immediate and only persists for the duration of your session, unless you export your preferences with Export-BskyPreference.

You can use any ANSI escape sequence or PSStyle setting. See examples.

This command and the bskyPreference variable were introduced in PSBluesky v2.3.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-BskyPreference Username -style "`e[3;38;5;135m"
```

Change the Username formatting preferences to use the specified ANSI escape sequence

### Example 2

```powershell
PS C:\> Get-BskyPreference LikedHighest | Set-BskyPreference -Style $PSStyle.Foreground.Red -Passthru

Setting      Style
-------      -----
LikedHighest `e[31m
```

Get a specific setting and assign a new style.

## PARAMETERS

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

### -Passthru

Write the updated preference setting to the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Setting

Enter the preference setting to change.

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

### -Style

Specify an ANSI sequence or PSStyle setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### BskyPreference

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyPreference](Get-BskyPreference.md)

[Export-BskyPreference](Export-BskyPreference.md)

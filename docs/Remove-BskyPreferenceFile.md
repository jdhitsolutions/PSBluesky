---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/removebskypreferencefile
schema: 2.0.0
---

# Remove-BskyPreferenceFile

## SYNOPSIS

Delete the user's PSBlueSky preference file.

## SYNTAX

```yaml
Remove-BskyPreferenceFile [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

If you have exported your PSBlueSky preference settings, you can delete the file with this command. The next time you import the PSBlueSky module, you will get the default preference settings. If you uninstall the PSBlueSky module, you should run this command first. Otherwise, you will need to manually delete the preference file.

This command and the bskyPreference variable were introduced in PSBluesky v2.3.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-BskyPreferenceFile
```

You will get a warning if no preference file is found.

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

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Export-BskyPreference](Export-BskyPreference.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/exportbskypreference
schema: 2.0.0
---

# Export-BskyPreference

## SYNOPSIS

Export your PSBlueSky formatting preference settings to a file.

## SYNTAX

```yaml
Export-BskyPreference [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Formatting preferences for the PSBluesky module are stored in a hash table preference variable. If customize preferences to better suit your environment, the changes exist for the duration of your PowerShell session or until you unload the PSBluesky module. The next time you import the module, you will get the default preference settings.

To preserve your changes, use Export-BskyPreference to save your preferences to a JSON file:

    $HOME\.psbluesky-preferences.json

If this file exists when you import the PSBluesky module, the module will load your preferences from this file.

To revert to the module's default preferences, simply delete the JSON file by running Remove-BskyPreferenceFile and re-import the module.

This command and the bskyPreference variable were introduced in PSBluesky v2.3.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-BskyPreference -Passthru

    Directory: C:\Users\Jeff

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           1/12/2025  3:21 PM           1085 .psbluesky-preferences.json
```

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

Show the export file object.

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

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Get-BskyPreference](Get-BskyPreference.md)

[Remove-BskyPreferenceFile](Remove-BskyPreferenceFile.md)

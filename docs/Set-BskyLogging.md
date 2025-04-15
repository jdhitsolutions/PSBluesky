---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/setbskylogging
schema: 2.0.0
---

# Set-BskyLogging

## SYNOPSIS

Configure PSBlueSky API logging.

## SYNTAX

```yaml
Set-BskyLogging [-Path] <String> [-Passthru] [<CommonParameters>]
```

## DESCRIPTION

Use this command to configure the logging path for API logging in the PSBluesky module. The module default is `$ENV:TEMP\bskyAPIlogging.json`, but you can use this command to change the location. The file must be a JSON file. The default is to not log API calls. If you enable logging, you can later disable it with the Disable-BskyLogging command.

When you set a new path, the global variable $bskyLogFile will be updated to reflect the new path.This makes it easier to work with the file in the PowerShell console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-BskyLogging c:\temp\api.json
```

The default behavior is not to write anything to the pipeline.

### Example 2

```powershell
PS C:\> Set-BskyLogging c:\temp\api.json -Passthru

LoggingEnabled LogFile          LogFileSize
-------------- -------          -----------
          True c:\temp\api.json        4639
```

## PARAMETERS

### -Passthru

Show the new API logging settings.

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

### -Path

Specify the file name and path for the log JSON file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### None

### BskyLoggingInfo

## NOTES

## RELATED LINKS

[Get-BskyLogging](Get-BskyLogging.md)

[Enable-BskyLogging](Enable-BskyLogging.md)

[Disable-BskyLogging](Disable-BskyLogging.md)

[Remove-BskyLogging](Remove-BskyLogging.md)

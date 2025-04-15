---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/disablebskylogging
schema: 2.0.0
---

# Disable-BskyLogging

## SYNOPSIS

Disable BlueSky API logging.

## SYNTAX

```yaml
Disable-BskyLogging [-Passthru] [<CommonParameters>]
```

## DESCRIPTION

API logging is controlled by settings the the PSBluesky session object. However, you should use module cmdlets to configure API logging. Logging is disabled by default on module import. If you enable it, you can later disable it in your session with this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> Disable-BskyLogging
```

The default doesn't write anything to the pipeline.

### Example 2

```powershell
PS C:\> Disable-BskyLogging -passthru

LoggingEnabled LogFile          LogFileSize
-------------- -------          -----------
         False c:\temp\api.json        4639
```

## PARAMETERS

### -Passthru

Show the update session object.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

### BskyLoggingInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Enable-BskyLogging](Enable-BskyLogging.md)

[Get-BskyLogging](Get-BskyLogging.md)

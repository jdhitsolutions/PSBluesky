---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Enable-BskyLogging

## SYNOPSIS

Enable BlueSky API logging.

## SYNTAX

```yaml
Enable-BskyLogging [-Passthru] [<CommonParameters>]
```

## DESCRIPTION

API logging is controlled by settings the the PSBluesky session object. However, you should use module cmdlets to configure API logging. Logging is disabled by default on module import. You can use the command to enable it.

When you enable logging, a global variable $bskyLogFile will be created that contains the path to the log file. This makes it easier to work with the file in the PowerShell console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Enable-BskyLogging
```

The default doesn't write anything to the pipeline.

### Example 2

```powershell
PS C:\> Enable-BskyLogging -passthru

LoggingEnabled LogFile          LogFileSize
-------------- -------          -----------
          True c:\temp\api.json        4639
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

## RELATED LINKS

[Disable-BskyLogging](Disable-BskyLogging.md)

[Get-BskyLogging](Get-BskyLogging.md)

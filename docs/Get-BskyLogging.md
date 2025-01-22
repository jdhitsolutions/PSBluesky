---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyLogging

## SYNOPSIS

Getting the current PSBlueSky API logging settings.

## SYNTAX

```yaml
Get-BskyLogging [<CommonParameters>]
```

## DESCRIPTION

Configuration for API logging in the PSBluesky module is controlled by the session object. However, you should use module cmdlets to manage API logging. You can use this command to get the current logging settings.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyLogging

LoggingEnabled LogFile          LogFileSize
-------------- -------          -----------
          True c:\temp\api.json        4639
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### BSkyLoggingInfo

## NOTES

## RELATED LINKS

[Set-BskyLogging](Set-BskyLogging.md)

[Enable-BskyLogging](Enable-BskyLogging.md)

[Disable-BskyLogging](Disable-BskyLogging.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/547504
schema: 2.0.0
---

# Format-SpectreConsole

## SYNOPSIS

Format PSBluesky output for SpectreConsole.

## SYNTAX

```yaml
Format-SpectreConsole [-InputObject] <PSObject> [-TitleColor <String>] [-BorderColor <String>][<CommonParameters>]
```

## DESCRIPTION

If you have the pwshSpectreConsole module installed, you can pipe some commands from the PSBluesky module to this command to customize the output. This output is intended for viewing in the console. This is a format command so you shouldn't attempt to pipe it to another command.

The command will accept output from these commands:

- Find-BskyPost
- Get-BskyFeed
- Get-BskyFollower
- Get-BskyFollowing
- Get-BskyLiked
- Get-BskyModuleInfo
- Get-BskyProfile
- Get-BskyTimeline

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyProfile | Format-SpectreConsole
```

## PARAMETERS

### -BorderColor

The color of the table border.
Use a SpectreConsole color name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Steelblue1_1
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Output from a PSBluesky command.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TitleColor

The color of the title text.
Use a SpectreConsole color name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Gold1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### Formatted SpectreConsole output

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

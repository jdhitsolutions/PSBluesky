---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskymoduleinfo
schema: 2.0.0
---

# Get-BskyModuleInfo

## SYNOPSIS

Get a summary of the PSBlueSky module.

## SYNTAX

```yaml
Get-BskyModuleInfo [-Verb <String>] [-Noun <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get a summary of the PSBlueSky module showing functions, aliases and a help synopsis. The default output includes clickable links to online command help and the module's GitHub repository.

## EXAMPLES

### Example 1

```text
PS C:\> Get-BskyModuleInfo

   Module: PSBlueSky [v2.7.0]

Name                      Alias               Synopsis
----                      -----               --------
Add-BskyImage                                 Upload an image to Bluesky.
Block-BskyUser                                Block a Bluesky user account.
Disable-BskyLogging                           Disable BlueSky API logging.
...
```

The default output includes clickable hyperlinks to th online help for each command in the module's GitHub repository.

### Example 2

```powershell
PS C:\> Get-BskyModuleInfo -verb remove

   Module: PSBlueSky [v2.7.0]

Name                      Alias             Synopsis
----                      -----             --------
Remove-BskyFollow         Unfollow-BskyUser Unfollow a Bluesky user.
Remove-BskyLogging                          Remove the PSBlueSky API log file.
Remove-BskyPreferenceFile                   Delete a PSBlueSky preference file.
```

### Example 3

```powershell
PS C:\> Get-BskyModuleInfo -noun *session

   Module: PSBlueSky [v2.7.0]

Name               Alias               Synopsis
----               -----               --------
Get-BskySession    bss                 Show your current Bluesky session.
Start-BSkySession                      Start a new Bluesky session.
Update-BskySession Refresh-BskySession Refresh the Bluesky session token.
```

## PARAMETERS

### -Noun

Get commands that match the given noun. This parameter was added in v2.7.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
Accept pipeline input: False
Accept wildcard characters: True
```

### -Verb

Get commands that match the given verb. This parameter was added in v2.7.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyModuleInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyPreference](Get-BskyPreference.md)

[Open-BskyHelp](Open-BskyHelp.md)

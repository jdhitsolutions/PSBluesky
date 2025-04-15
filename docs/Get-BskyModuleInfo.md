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
Get-BskyModuleInfo [<CommonParameters>]
```

## DESCRIPTION

Use this command to get a summary of the PSBlueSky module showing functions, aliases and a help synopsis. The default output includes clickable links to online command help and the module's GitHub repository.

## EXAMPLES

### Example 1

```text
PS C:\> Get-BskyModuleInfo

   Module: PSBlueSky [v2.6.0]

Name                      Alias               Synopsis
----                      -----               --------
Add-BskyImage                                 Upload an image to Bluesky.
Block-BskyUser                                Block a Bluesky user account.
Disable-BskyLogging                           Disable BlueSky API logging.
Enable-BskyLogging                            Enable BlueSky API logging.
Export-BskyPreference                         Export your PSBlueSky formatting
                                              preference settings to a file.
Find-BskyPost             bsf Search-BskyPost Find Bluesky posts using a search term or text.
Find-BskyUser             bsu                 Search for Bluesky user accounts.
Get-BskyAccountDID                            Resolve a Bluesky account name to its DID.
Get-BskyBlockedList       bsblocklist         Get your subscribed blocked lists.
...
```

The default output includes clickable hyperlinks to th online help for each command in the module's GitHub repository.

## PARAMETERS

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

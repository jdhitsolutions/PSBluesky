---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskySession

## SYNOPSIS

Show your current Bluesky session.

## SYNTAX

```yaml
Get-BskySession [<CommonParameters>]
```

## DESCRIPTION

This command will display API information about your current Bluesky session. The object will be created when your run any module command or create a Bluesky access token. The output object includes alias properties you might find helpful. This is useful for troubleshooting and debugging but otherwise, you shouldn't need to use this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskySession

   User: jdhitsolutions.com

Active AccessToken             RefreshToken            Age
------ -----------             ------------            ---
True   eyJ0eXAiOiJhdCtqd3Qi... eyJ0eXAiOiJyZWZyZXNo... 00:21:56.7958913
```

Default output is a formatted table. Pipe the command to Select-Object to see all of object properties.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskySession

## NOTES

## RELATED LINKS

[Get-BskyAccessToken](Get-BskyAccessToken.md)

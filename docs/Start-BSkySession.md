---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/startbskysession
schema: 2.0.0
---

# Start-BSkySession

## SYNOPSIS

Start a new Bluesky session.

## SYNTAX

```yaml
Start-BSkySession [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

Before you can run any PSBluesky module command, you need to initialize or start a Bluesky session. Specify a credential with your Bluesky username and password.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-BSkySession -Credential $cred
```

You might want to store the credential in a Secrets management vault and pass to the command as a variable.

## PARAMETERS

### -Credential

A PSCredential with your Bluesky username and password

```yaml
Type: PSCredential
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

### PSBlueskySession

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskySession](Get-BSkySession.md)

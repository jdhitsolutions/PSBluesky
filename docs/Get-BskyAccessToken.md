---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyAccessToken

## SYNOPSIS

Get a Bluesky access token

## SYNTAX

```yaml
Get-BskyAccessToken [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

This command is called by PSBluesky module commands to authenticate you and return an access token.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyAccessToken
eyJ0eXAiOi....
```

## PARAMETERS

### -Credential

A PSCredential with your Bluesky username and password.

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

### System.String

## NOTES

## RELATED LINKS

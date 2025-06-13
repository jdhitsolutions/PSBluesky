---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskyaccountdid
schema: 2.0.0
---

# Get-BskyAccountDID

## SYNOPSIS

Resolve a Bluesky account name to its DID.

## SYNTAX

```yaml
Get-BskyAccountDID [-AccountName] <String> [<CommonParameters>]
```

## DESCRIPTION

Use this command to resolve your Bluesky account name to its DID.
The DID is a unique identifier for your account that you can use to created an AppPassword credential.
This command does not require authentication.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyAccountDID jdhitsolutions.com
did:plc:ohgsqpfsbocaaxusxqlgfvd7
```

## PARAMETERS

### -AccountName

Enter the user's Bluesky account name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Handle

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyProfile](Get-BskyProfile.md)

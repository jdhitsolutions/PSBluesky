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

This command will display API information about your current Bluesky session. This is useful for troubleshooting and debugging but otherwise, you shouldn't need to use this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskySession

Handle     : jdhitsolutions.com
Email      : jhicks@jdhitsolutions.com
Active     : True
AccessJwt  : eyJ0eXAiOiJhdCtqd3QiLCJhbGciOiJFUzI1NksifQ....
RefreshJwt : eyJ0eXAiOiJyZWZyZXNoK2p3dCIsImFsZyI6IkVTMj...
DiD        : did:plc:ohgsqpfsbocaaxusxqlgfvd7
DidDoc     : @{@context=System.Object[]; id=did:plc:ohgsqpfsbocaaxusxqlgfvd7;
             alsoKnownAs=System.Object[]; verificationMethod=System.Object[];
             service=System.Object[]}
Date       : 10/31/2024 1:56:04 PM
UserName   : jdhitsolutions.com
Age        : 00:03:32.8493629
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskySession

## NOTES

## RELATED LINKS

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyAccountDID

## SYNOPSIS

Résoudre un nom de compte Bluesky en son DID

## SYNTAXE

```yaml
Get-BskyAccountDID [-AccountName] <String> [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour résoudre votre nom de compte Bluesky en son DID.
Le DID est un identifiant unique pour votre compte que vous pouvez utiliser pour créer un identifiant AppPassword.
Cette commande ne nécessite pas d'authentification.

## EXEMPLES

### EXEMPLE 1
```
PS C:\> Get-BskyAccountDID jdhitsolutions.com
did:plc:ohgsqpfsbocaaxusxqlgfvd7
```

## PARAMÈTRES

### -AccountName

Entrez le nom de compte Bluesky de l'utilisateur.

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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## SORTIES

### System.String

## REMARQUES

## LIENS CONNEXES

[Get-BskyProfile](Get-BskyProfile.md)
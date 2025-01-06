---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskySession

## SYNOPSIS

Affichez votre session Bluesky actuelle.

## SYNTAXE

```yaml
Get-BskySession [<CommonParameters>]
```

## DESCRIPTION

Cette commande affichera les informations de l'API concernant votre session Bluesky actuelle. L'objet sera créé lorsque vous exécuterez une commande de module ou créerez un jeton d'accès Bluesky. L'objet de sortie comprend des propriétés d'alias que vous pourriez trouver utiles. Cela est utile pour le dépannage et le débogage, mais sinon, vous ne devriez pas avoir besoin d'utiliser cette commande.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskySession

   Utilisateur: jdhitsolutions.com

Accès Actif             Jeton de rafraîchissement            Âge
------ -----------             ------------            ---
True   eyJ0eXAiOiJhdCtqd3Qi... eyJ0eXAiOiJyZWZyZXNo... 00:21:56.7958913
```

La sortie par défaut est un tableau formaté. Redirigez la commande vers Select-Object pour voir toutes les propriétés de l'objet.

## PARAMÈTRES

### CommonParameters
Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun

## OUTPUTS

### PSBlueskySession

## REMARQUES

## LIENS CONNEXES

[Get-BskyAccessToken](Get-BskyAccessToken.md)

[Update-BskySession](Update-BskySession.md)

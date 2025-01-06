---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyFollowing

## SYNOPSIS

Obtenez une liste des comptes Bluesky que vous suivez

## SYNTAXE

### Limite (Par défaut)

```yaml
Get-BskyFollowing [[-Limit] <Int32>] [<CommonParameters>]
```

### Tout

```yaml
Get-BskyFollowing [-All] [<CommonParameters>]
```

## DESCRIPTION

Cette commande renverra une liste des comptes Bluesky que vous suivez. Vous pouvez en obtenir entre 1 et 100. La valeur par défaut est 50. Ou utilisez -All pour obtenir tous les comptes que vous suivez.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyFollowing -Limit 2

Affichage    Nom d'utilisateur          Description
-------      --------                   -----------
Lou Creemers lovelacecoding.bsky.social Microsoft MVP | ❤️ .NET | Professeur à l'université |
                                        Membre du conseil d'administration de la .NET Foundation 💜
                                        | Fier amateur de blagues de papa
             mikeshepard70.bsky.social
```

La sortie par défaut inclut des liens cliquables vers le profil de l'utilisateur.

## PARAMÈTRES

### -Limite

Entrez le nombre de comptes que vous suivez à récupérer entre 1 et 100.
La valeur par défaut est 50.

```yaml
Type: Int32
Parameter Sets: Limite
Aliases:

Required: False
Position: 0
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tout

Retourner tous les abonnés

```yaml
Type: SwitchParameter
Parameter Sets: Tout
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun

## OUTPUTS

### PSBlueskyFollowProfile

## REMARQUES

## LIENS CONNEXES

[Get-BskyFollowers](Get-BskyFollowers.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyFollowers

## SYNOPSIS

Obtenez vos abonnés Bluesky

## SYNTAXE

### Limite (Par défaut)

```yaml
Get-BskyFollowers [[-Limit] <Int32>] [<CommonParameters>]
```

### Tous

```yaml
Get-BskyFollowers [-All] [<CommonParameters>]
```

## DESCRIPTION

Cette commande renverra une liste de vos abonnés Bluesky. Vous pouvez en obtenir entre 1 et 100. La valeur par défaut est 50. Ou utilisez le paramètre Tous pour parcourir tous les abonnés.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyFollowers -Limit 2

Affichage     Nom d'utilisateur  Description
-------       --------           -----------
Jonathan Lank jpluk.bsky.social
Libby Brown   trubludevil.social Chef de produit @ SpruceID. Maman. Enthousiaste des portefeuilles numériques et des clés de passe. Fan de Duke. Habitant de la banlieue de Seattle.
```

La sortie par défaut inclut des liens cliquables.

## PARAMÈTRES

### -Limite

Entrez le nombre d'abonnés à récupérer entre 1 et 100.
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

### -Tous

Retourner tous les abonnés

```yaml
Type: SwitchParameter
Parameter Sets: Tous
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## ENTRÉES

### Aucun

## SORTIES

### PSBlueskyFollowProfile

## REMARQUES

## LIENS CONNEXES

[Get-BskyFollowing](Get-BskyFollowing.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Find-BskyUser

## SYNOPSIS

Rechercher des comptes utilisateurs Bluesky

## SYNTAXE

```yaml
Find-BskyUser [[-UserName] <String>] [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Vous pouvez utiliser cette commande pour rechercher des comptes utilisateurs Bluesky. L'hypothèse est que vous rechercherez par nom, mais la valeur que vous entrez pour le paramètre UserName recherchera également la description de l'utilisateur.

Cette commande ne nécessite pas d'authentification.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Find-BskyUser -UserName "dave carroll"

   Nom d'utilisateur: Dave Carroll [thedavecarroll.com]

Créé                Description
-----               -----------
29/04/2023 06:52:59 #PowerShell #Développeur et passionné avec un côté
                     #DevOps, #Python, infrastructure, et #RetroComputing.
                     Cinéphile de longue date et amateur de jeux de mots.

                     #Aspie #INTJ #9w1
                     Il/Lui

                     https://thedavecarroll.com

   Nom d'utilisateur: Dave Carroll [davecarroll01.bsky.social]

Créé                Description
-----               -----------
17/12/2023 15:17:42
```

La sortie par défaut inclut des liens cliquables vers le profil de l'utilisateur.

## PARAMÈTRES

### -Limit

Entrez le nombre de résultats à récupérer entre 1 et 100.
La valeur par défaut est 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName

Entrez une chaîne de recherche. Cela sera utilisé pour rechercher le nom et la description de l'utilisateur.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Profile

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSBlueskySearchResult

## REMARQUES

## LIENS CONNEXES

[Get-BskyProfile](Get-BskyProfile.md)
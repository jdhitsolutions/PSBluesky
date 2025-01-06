---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyFeed

## SYNOPSIS

Obtenez votre flux Bluesky

## SYNTAXE

```yaml
Get-BskyFeed [[-Limit] <Int32>] [-UserName <String>] [<CommonParameters>]
```

## DESCRIPTION

Par défaut, cette commande renverra vos publications et réponses, mais vous pouvez spécifier n'importe quel nom d'utilisateur Bluesky. La sortie par défaut doit comporter des liens cliquables. Vous pouvez obtenir entre 1 et 100 éléments de flux. La valeur par défaut est 50.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyFeed -Limit 3

Jeff Hicks [jdhitsolutions.com]

J'utilise la variable d'information #PowerShell pour stocker la réponse brute de l'API Bluesky.

Date                   Aimé Répondu Reposté Cité
----                   ---- ------- ------- ----
27/10/2024 12:05:15 PM     1       0        0      0


Jeff Hicks [jdhitsolutions.com]

Ajout d'une commande #PowerShell pour obtenir les éléments que vous avez publiés sur votre flux.

Date                   Aimé Répondu Reposté Cité
----                   ---- ------- ------- ----
27/10/2024 11:49:25 AM     1       0        0      0


Jeff Hicks [jdhitsolutions.com]

Ajout d'une commande Get-BskyFollowers à mon module #PowerShell.

Date                  Aimé Répondu Reposté Cité
----                  ---- ------- ------- ----
27/10/2024 9:54:53 AM     3       0        0      0
```

La valeur par défaut est de 50 éléments de flux. La sortie par défaut comprend des liens cliquables.

## PARAMÈTRES

### -Limit

Entrez le nombre de comptes que vous suivez pour récupérer entre 1 et 100.
La valeur par défaut est 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName

Entrez le profil ou le nom d'utilisateur pour obtenir le flux d'un autre utilisateur

```yaml
Type: String
Parameter Sets: (All)
Aliases: Profile, Handle

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, consultez [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun
## OUTPUTS

### PSBlueskyFeedItem
## REMARQUES

## LIENS CONNEXES

[Get-BskyTimeline](Get-BskyTimeline.md)

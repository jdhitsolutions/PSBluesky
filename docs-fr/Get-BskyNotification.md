---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyNotification

## SYNOPSIS

Obtenir les notifications Bluesky.

## SYNTAX

```yaml
Get-BskyNotification [[-Limit] <Int32>] [-Filter <String>] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour récupérer les notifications Bluesky. Vous pouvez limiter le nombre de notifications retournées jusqu'à 100. La valeur par défaut est 50. Il existe une option de filtrage basée sur le type, mais le filtrage est appliqué après que le nombre spécifié de notifications soit récupéré. Le paramètre est une commodité pour que vous n'ayez pas à construire une expression utilisant Where-Object.

La sortie par défaut utilise un fichier de format personnalisé pour afficher les notifications. Le nom du compte est affiché comme un hyperlien vers le profil Bluesky du compte. Le texte référencé doit également être cliquable. La sortie par défaut inclut des emojis.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyNotification -Limit 5

Date               Account                    Subject
----               -------                    -------
11/13/2024 1:36 PM ➡  mscommunity.bsky.social
11/13/2024 1:24 PM ➡  Oscar
11/13/2024 1:18 PM ➡  dirteam.bsky.social
11/13/2024 1:04 PM ➡  Hoang Chu
11/13/2024 1:01 PM 👍 Madhu PERERA            I have published v1.2.0 of the
                                              PSBluesky module to the
                                              #PowerShell Gallery. Run
                                              Open-BskyHelp to read the help PDF
```

La sortie par défaut inclut des emojis et des liens cliquables. Les noms de compte longs seront tronqués dans la sortie formatée.

### Exemple 2

```powershell
PS C:\> Get-BskyNotification -Limit 10 -Filter Follow

Date               Account                    Subject
----               -------                    -------
11/14/2024 9:12 AM ➡  Master Packager
11/14/2024 9:06 AM ➡  Reed M. Wiedower (CT...
11/14/2024 8:34 AM ➡  foontzoot 🇨🇦
11/14/2024 8:19 AM ➡  Hanna
11/14/2024 7:52 AM ➡  Gavin Ashton
11/14/2024 6:58 AM ➡  Michel Zehnder
11/14/2024 5:59 AM ➡  handle.invalid
11/14/2024 5:48 AM ➡  lsdima.bsky.social
11/14/2024 5:32 AM ➡  romanoj.bsky.social
```

Filtrer les notifications pour n'afficher que les notifications de type Follow parmi les 10 dernières notifications.

## PARAMÈTRES

### -Limit

Entrez le nombre de notifications à récupérer entre 1 et 100.
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

### -Filter

Entrez le type de notifications à récupérer. La valeur par défaut est All.
Les valeurs possibles sont "Like", "Follow", "Repost", "Mention", et "Reply".

```yaml
Type: String
Parameter Sets: (All)
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

### None

## OUTPUTS

### PSBlueskyNotification

## NOTES

## RELATED LINKS

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyTimeline

## SYNOPSIS

Obtenez votre timeline Bluesky

## SYNTAXE

```yaml
Get-BskyTimeline [[-Limit] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Cette commande renverra tous les éléments de votre timeline Bluesky.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyTimeline -Limit 10

► 11/4/2024 11:38:45 AM ◄ 🦋 Christian Buckley [buckleyplanet.bsky.social]

 Assurez-vous de consulter l'épisode 288 de la série d'interviews #MVPbuzzChat avec
Business Applications MVP Stefan Maroń (@StefanMaron) partageant son histoire d'origine
sur devenir un MVP Microsoft https://buff.ly/4fa3iv7 #MVPBuzz
❤ 0  📧0  💬0
...
```

La sortie par défaut utilise un fichier de format personnalisé qui inclut des emojis et le formatage $PSStyle. Le texte et le nom du compte doivent être des liens cliquables qui ouvriront l'élément de la timeline.

## PARAMÈTRES

### -Limit

Entrez le nombre de publications de la timeline à récupérer entre 1 et 100.
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

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun

## OUTPUTS

### PSBlueskyTimelinePost

## REMARQUES

## LIENS CONNEXES

[Get-BskyFeed](Get-BskyFeed.md)

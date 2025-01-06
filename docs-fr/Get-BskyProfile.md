---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyProfile

## SYNOPSIS

Obtenir un profil Bluesky

## SYNTAXE

```yaml
Get-BskyProfile [[-UserName] <String>] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour récupérer un profil Bluesky. Par défaut, ce sera votre profil basé sur les informations d'identification que vous avez utilisées pour démarrer votre session Bluesky, mais vous pouvez obtenir n'importe quel profil si vous connaissez le nom d'utilisateur. Le nom d'utilisateur est sensible à la casse. La sortie par défaut inclut des liens cliquables.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Get-BskyProfile

Jeff Hicks [jdhitsolutions.com]

Auteur/Enseignant/MVP/Guide PowerShell ✍️
Prof. PowerShell Émérite 🎓
Professionnel de l'informatique chevronné et grincheux - https://jdhitsolutions.github.io/
🎼Compositeur amateur - https://musescore.com/user/26698536
Amateur de vin 🍷🐶 et amoureux des chiens


Créé               Publications Abonnés Abonnements Listes
-----               ------------ --------- --------- -----
21/05/2023 10:44:48   544       322       177     0
```

La sortie par défaut inclut des liens cliquables.

### Exemple 2

```powershell
PS C:\> Get-BskyProfile jsnover.bsky.social

Jeffrey Snover [jsnover.bsky.social]

Inventeur de PowerShell, Lecteur, Geek de la science et de la géopolitique, Ingénieur distingué de Google


Créé              Publications Abonnés Abonnements Listes
-----              ------------ --------- --------- -----
01/05/2023 10:14:33    32       592        26     0
```

Vous pouvez obtenir n'importe quel profil si vous connaissez le nom d'utilisateur.

## PARAMÈTRES

### -UserName

Entrez le profil ou le nom d'utilisateur.

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

## ENTRÉES

### System.String

## SORTIES

### PSBlueskyProfile

## REMARQUES

## LIENS CONNEXES

[Find-BskyUser](Find-BskyUser.md)

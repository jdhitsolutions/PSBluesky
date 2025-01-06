---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# New-BskyPost

## SYNOPSIS

Créer un post Bluesky

## SYNTAXE

```yaml
New-BskyPost [-Message] <String> [-ImagePath <String>] [-ImageAlt <String>] [-Label <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour publier sur Bluesky depuis PowerShell. Vous pouvez éventuellement inclure des images. Si vous incluez une image, vous devez inclure une valeur de texte ALT. Si votre message inclut des liens URL, ils seront convertis en hyperliens. Assurez-vous que vos liens ont un espace blanc des deux côtés dans le texte de votre message.

Si votre message inclut une référence à un autre compte, vous devez utiliser le symbole `@` suivi du nom du compte. Par exemple, `@jdhitsolutions.com`. La référence sera transformée en un lien cliquable en ligne. Cette commande NE VALIDERA PAS les références ou les liens.

Tout texte précédé d'un # sera traité comme une balise.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> New-BskyPost "Ajout de la documentation d'aide à mon module Bluesky #PowerShell."
https://bsky.app/profile/did:plc:ohgsqpfsbocaaxusxqlgfvd7/post/3l7j3u7zu6n2w
```

La sortie est une URL vers le post. Le post créera une balise comme pour #PowerShell.

### Exemple 2

```powershell
PS C:\> $m = "Test de plusieurs liens de style Markdown depuis mon module #PowerShell [PSBluesky](https://github.com/jdhitsolutions/PSBluesky) que vous pouvez trouver sur la [PowerShell Gallery](https://www.powershellgallery.com/packages/PSBlueSky/0.6.0)"
PS C:\> skeet $m
```

Vous pouvez insérer des liens de style markdown dans le texte de votre message. Cet exemple utilise l'alias `skeet` pour `New-BskyPost`. Évitez de nicher des balises à l'intérieur des liens.

### Exemple 3

```powershell
PS C:\> New-BskyPost -Message "C'est génial https://microsoft.com/powershell" -ImagePath c:\images\awesome.jpg -ImageAlt "Génial"
```

Un exemple qui publie une image. L'URL sera formatée comme un hyperlien cliquable. Bien que techniquement non requis, vous devez inclure un texte ALT pour l'image.

## PARAMÈTRES

### -Confirm

Vous demande de confirmer avant d'exécuter la cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagePath

Le chemin vers le fichier image. L'image doit être inférieure à 1 Mo et le format recommandé est PNG. Évitez les arrière-plans transparents.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ImageAlt

Vous devez inclure un texte ALT pour l'image.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Alt

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Message

Le texte du post.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Montre ce qui se passerait si la cmdlet s'exécutait.
La cmdlet n'est pas exécutée.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label

Lorsque vous publiez une image, vous pouvez l'étiqueter comme par exemple « sexuel » pour un contenu sexuellement suggestif mais sans dénudation, « nudité » pour un nu artistique/non érotique et « pornographie » pour un contenu pour adultes. L'étiquette doit comporter entre 3 et 128 caractères.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

Cette cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucun

## OUTPUTS

### System.String

## NOTES

## LIENS CONNEXES

[Get-BskyFeed](Get-BskyFeed.md)

[Add-BskyImage](Add-BskyImage.md)

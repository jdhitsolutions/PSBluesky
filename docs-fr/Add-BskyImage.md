---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Add-BskyImage

## SYNOPSIS

Télécharger une image vers Bluesky

## SYNTAXE

```yaml
Add-BskyImage [-ImagePath] <String> [-ImageAlt <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Cette commande téléchargera une image vers Bluesky et renverra un lien que vous pourrez utiliser dans votre publication. Cette commande sera appelée lorsque vous créerez une nouvelle publication et spécifierez une image. Vous ne devriez pas avoir besoin d'appeler cette commande directement.

L'image doit être inférieure à 1 Mo et le format recommandé est PNG. Évitez les arrière-plans transparents.

## EXEMPLES

### Exemple 1

```powershell
PS C:\> Add-BskyImage -ImagePath "C:\Users\user\Documents\image.png" -ImageAlt "texte alternatif ici"
```

Vous devriez utiliser du texte ALT pour les images.

## PARAMÈTRES

### -ImagePath

Le chemin vers le fichier image.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageAlt

Vous devriez inclure du texte ALT pour l'image.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Alt

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Vous demande une confirmation avant d'exécuter la cmdlet.

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

### -WhatIf

Montre ce qui se passerait si la cmdlet s'exécute.
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

### CommonParameters

Cette cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## ENTRÉES

### Aucune

## SORTIES

### PSBlueskyImageUpLoad

## REMARQUES

## LIENS CONNEXES

[New-BskyPost](New-BskyPost.md)
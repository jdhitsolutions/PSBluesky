---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Add-PSBlueskyImage

## SYNOPSIS

Upload an image to Bluesky

## SYNTAX

```yaml
Add-PSBlueskyImage [-ImagePath] <String> [-ImageAlt <String>] -Credential <PSCredential>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will upload an image to Bluesky and return a link that you can use in your post. This command will be called when you create a new post and specify an image. You shouldn't need to call this command directly.

## EXAMPLES

### Example 1

```powershell
PS C:\> Add-PSBlueskyImage -ImagePath "C:\Users\user\Documents\image.png" -ImageAlt "alt tet here" -credential $credential
```

You should use ALT text for images.

## PARAMETERS

### -ImagePath

The path to the image file.

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

You should include ALT text for the image.

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

### -Credential

A PSCredential with your Bluesky username and password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[New-PSBlueskyPost](New-PSBlueskyPost.md)


---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# New-PSBlueskyPost

## SYNOPSIS

Create a Bluesky post

## SYNTAX

```yaml
New-PSBlueskyPost [-Message] <String> [-ImagePath <String>] [-ImageAlt <String>] -Credential <PSCredential> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to post to Bluesky from PowerShell. You can optionally include images. If you include an image you should include an ALT text value. If your message includes URL links, they will be converted into hyperlinks. Be sure that your links have a whitespace on both sides in your message text.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-PSBlueskyPost "Adding help documenation to my Bluesky #PowerShell module."
https://bsky.app/profile/did:plc:ohgsqpfsbocaaxusxqlgfvd7/post/3l7j3u7zu6n2w
```

The output is a URL to the post. This example assumes the credential has been set in $PSDefaultParameterValues.

## PARAMETERS

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

### -ImageAlt

You should include ALT text for the image.

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

### -ImagePath

The path to the image file.

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

### -Message

The text of the post

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Get-PSBlueskyFeed](Get-PSBlueskyFeed.md)

[Add-PSBlueskyImage](Add-PSBlueskyImage.md)

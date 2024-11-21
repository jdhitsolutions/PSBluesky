---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# New-BskyPost

## SYNOPSIS

Create a Bluesky post

## SYNTAX

```
New-BskyPost [-Message] <String> [-ImagePath <String>] [-ImageAlt <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to post to Bluesky from PowerShell. You can optionally include images. If you include an image you should include an ALT text value. If your message includes URL links, they will be converted into hyperlinks. Be sure that your links have a whitespace on both sides in your message text.

If your message includes a reference to another account, you should use the `@` symbol followed by the account name. For example, `@jdhitsolutions.com`. The reference will be turned into a clickable inline link. This command WILL NOT validate any references or links.

Any text preceded by a # will be treated as a tag.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-BskyPost "Adding help documentation to my Bluesky #PowerShell module."
https://bsky.app/profile/did:plc:ohgsqpfsbocaaxusxqlgfvd7/post/3l7j3u7zu6n2w
```

The output is a URL to the post. The post will create a tag like for #PowerShell.

### Example 2

```powershell
PS C:\> $m = "Testing multiple Markdown style links from my #PowerShell [PSBluesky module](https://github.com/jdhitsolutions/PSBluesky) which you can find on the [PowerShell Gallery](https://www.powershellgallery.com/packages/PSBlueSky/0.6.0)"
PS C:\> skeet $m
```

You can insert markdown style links in your message text. This example is using the `skeet` alias for `New-BskyPost`. Avoid nesting tags inside of links.

### Example 3

```powershell
PS C:\> New-BskyPost -Message "This is awesome https://microsoft.com/powershell" -ImagePath c:\images\awesome.jpg -ImageAlt "Awesomeness"
```

An example that posts an image. The URL will be formatted as a clickable hyperlink. While not technically required, you should include ALT text for the image.

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

### -ImagePath

The path to the image file. The image must be less than 1MB in size and the recommended format is PNG. Avoid transparent backgrounds.

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

You should include ALT text for the image.

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

### -Label

When posting an image it can be labeled as e.g. for 'sexual' for sexually suggestive but non-nude, 'nudity' for artistic / non-erotic nude, and 'porn' for adult content

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: false
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Accept pipeline input: True (ByPropertyName)
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

[Get-BskyFeed](Get-BskyFeed.md)

[Add-BskyImage](Add-BskyImage.md)

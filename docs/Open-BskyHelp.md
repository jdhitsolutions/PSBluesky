---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Open-BskyHelp

## SYNOPSIS

Open the PSBluesky help document

## SYNTAX

```yaml
Open-BskyHelp [-AsMarkdown]  [<CommonParameters>]
```

## DESCRIPTION

Use this command to open the PDF help document for the PSBluesky module with the associated application for PDF files. As an alternative you can view the documentation as a markdown document.

## EXAMPLES

### Example 1

```powershell
PS C:\> Open-BskyHelp
```

The file should open in the default application for PDF files.

### Example 2

```powershell
PS C:\> Open-BskyHelp -AsMarkdown | more
```

View the help file a markdown document.

## PARAMETERS

### -AsMarkdown

Open the help file as markdown.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: md

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

### None

### System.String

## NOTES

## RELATED LINKS

[PSBluesky GitHub Repository:](https://github.com/jdhitsolutions/PSBluesky)

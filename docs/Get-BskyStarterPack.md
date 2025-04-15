---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/e6b498
schema: 2.0.0
---

# Get-BskyStarterPack

## SYNOPSIS

Get Bluesky starter packs for a specified profile.

## SYNTAX

```yaml
Get-BskyStarterPack [[-UserName] <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve the starter packs for a specified Bluesky profile. The default will be your profile based on the credential you used to start your Bluesky session, but you can get the starter packs for any profile if you know the user name. The username is case-sensitive. The default output includes clickable links.

This command was added in v2.6.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyStarterPack

Pluralsight Authors Starter Pack [https://bsky.app/starter-pack/did:plc:ohgsqpfsbocaaxusxqlgfvd7/3l7spfvbk5w2n]

A starter pack of Pluralsight authors and content creators. This is a personal list, unaffiliated with Pluralsight.com. If you are a Pluralsight author, ping me to get added to the list.


Created          Creator            CreatorDisplay Feeds                                                  Labels
-------          -------            -------------- -----                                                  ------
31/10/2024 12:56 jdhitsolutions.com Jeff Hicks     {Microsoft Azure, Developers, DevOps | SecOps | Cloud} {}
```

The default output includes clickable links.

### Example 2

```powershell
PS C:\> Get-BskyStarterPack wragg.io

Azure Spring Clean 2025 [https://bsky.app/starter-pack/did:plc:re4hy2aynaii3jfcgl2s5gmp/3ljhnp6v2mq2y]

Contributors to the Azure Spring Clean 2025 free community event promoting well-managed Azure tenants.


Created          Creator  CreatorDisplay Feeds Labels
-------          -------  -------------- ----- ------
03/03/2025 09:38 wragg.io Mark Wragg           {}
```

You can get the starter packs for any profile if you know the user name.

## PARAMETERS

### -UserName

Enter the profile or username. The default is your profile.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSBlueskyStarterPack

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyStarterPackList](Get-BskyStarterPackList.md)

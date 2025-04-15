---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/347462
schema: 2.0.0
---

# Get-BskyStarterPackList

## SYNOPSIS

Get a Bluesky starter pack and the list of profiles it contains.

## SYNTAX

### Limit (Default)

```yaml
Get-BskyStarterPackList [[-Uri] <String>] [-Limit <Int32>] [<CommonParameters>]
```

### All

```yaml
Get-BskyStarterPackList [[-Uri] <String>] [-All] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve a specified starter pack and the member profiles contains. You must specify the AT protocol URI for the starter pack. This can be retrieved via Get-BskyStarterPack, the output of which can be piped into Get-BskyStarterPackList.

Note the command will return a maximum of 50 members by default. To return all members use the -All switch. Use -Limit to configure how many members to return, between 1 and 100.

Note that a warning will be shown if the number of members returned is less than the starter packs item count, however this may be expected if one or more members has blocked the creator of the starter pack, even when using -All.

This command was added in v2.6.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyStarterPack | Get-BskyStarterPackList

Pluralsight Authors Starter Pack [https://bsky.app/starter-pack/did:plc:ohgsqpfsbocaaxusxqlgfvd7/3l7spfvbk5w2n]

A starter pack of Pluralsight authors and content creators. This is a personal list, unaffiliated with Pluralsight.com. If you are a Pluralsight author, ping me to get added to the list.


Created          Creator            CreatorDisplay MemberCount Members
-------          -------            -------------- ----------- -------
31/10/2024 12:56 jdhitsolutions.com Jeff Hicks              49 {matthewrenze.bsky.social, alisaduncan.dev, mhadaily.bsky.social, jesperdj.bsky.social…}
```

### Example 2

```powershell
PS C:\> Get-BskyStarterPackList at://did:plc:re4hy2aynaii3jfcgl2s5gmp/app.bsky.graph.starterpack/3ljhnp6v2mq2y

Azure Spring Clean 2025 [https://bsky.app/starter-pack/did:plc:re4hy2aynaii3jfcgl2s5gmp/3ljhnp6v2mq2y]

Contributors to the Azure Spring Clean 2025 free community event promoting well-managed Azure tenants.


Created          Creator  CreatorDisplay MemberCount Members
-------          -------  -------------- ----------- -------
03/03/2025 09:38 wragg.io Mark Wragg              29 {azurealan.ie, cfgcloud.io, wmatthyssen.com, autosysops.bsky.social…}
```

You can get any starter pack if you know its AT protocol URI.

## PARAMETERS

### -All

Return All starter park list items

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit

Enter the number of starter pack list items to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: Limit
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri

Enter the at-uri for the starter pack.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### PSBlueskyStarterPackList

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyStarterPack](Get-BskyStarterPack.md)

---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-PSBlueskyFollowers

## SYNOPSIS

Get your Bluesky followers

## SYNTAX

```yaml
Get-PSBlueskyFollowers [[-Limit] <Int32>] [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

This command will return a list of your Bluesky followers, You can get between 1 and 100. The default is 50. Research into enumerating all followers is ongoing.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSBlueskyFollowers -Limit 2

Display       Username           Description
-------       --------           -----------
Jonathan Lank jpluk.bsky.social
Libby Brown   trubludevil.social Product manager @ SpruceID. Mom. Digital
                                 Wallet and Passkey enthusiast. Duke fan.
                                 Dweller of Seattle exurbia.

```

The default output includes clickable links. This example assumes the credential has been set in $PSDefaultParameterValues.

## PARAMETERS

### -Credential

A PSCredential with your Bluesky username and password.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit

Enter the number of followers to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyFollowProfile

## NOTES

## RELATED LINKS

[Get-PSBlueskyFollowing](Get-PSBlueskyFollowing.md)

---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-PSBlueskyFollowing

## SYNOPSIS

Get a list of Bluesky accounts that you follow

## SYNTAX

```yaml
Get-PSBlueskyFollowing [[-Limit] <Int32>] [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

This command will return a list of Bluesky accounts that you follow. You can get between 1 and 100. Research into enumerating all accounts is ongoing.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSBlueskyFollowing -Limit 2

Display      Username                   Description
-------      --------                   -----------
Lou Creemers lovelacecoding.bsky.social Microsoft MVP | ❤️ .NET | Uni teacher |
                                        Board member of the .NET Foundation 💜
                                        | Proud dad joke lover
             mikeshepard70.bsky.social

```

The default output includes clickable links to the user's profile. This example assumes the credential has been set in $PSDefaultParameterValues.

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

Enter the number of accounts that you follow to retrieve between 1 and 100.
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

[Get-PSBlueskyFollowers](Get-PSBlueskyFollowers.md)

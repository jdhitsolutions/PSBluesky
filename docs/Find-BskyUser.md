---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Find-BskyUser

## SYNOPSIS

Search for Bluesky user accounts

## SYNTAX

```yaml
Find-BskyUser [[-UserName] <String>] [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION

You can use this command to search for Bluesky user accounts. The assumption is that you will be searching by name, but the value you enter for the UserName parameter will also search the user's description.

## EXAMPLES

### Example 1

```powershell
PS C:\> Find-BskyUser -UserName "dave carroll"

   Username: Dave Carroll [thedavecarroll.com]

Created              Description
-------              -----------
4/29/2023 6:52:59 AM #PowerShell #Developer and enthusiast with a side of
                     #DevOps, #Python, infrastructure, and #RetroComputing.
                     Lifelong #cinephile and #punster.

                     #Aspie #INTJ #9w1
                     He/Him

                     https://thedavecarroll.com

   Username: Dave Carroll [davecarroll01.bsky.social]

Created               Description
-------               -----------
12/17/2023 3:17:42 PM
```

The default output includes clickable links to the user's profile.

## PARAMETERS

### -Limit
Enter the number of results to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
Enter a search string. This will be used to search the user's name and description.

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

### PSBlueskySearchResult

## NOTES

## RELATED LINKS

[Get-BskyProfile](Get-BskyProfile.md)
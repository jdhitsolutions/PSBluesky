---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyNotification

## SYNOPSIS

Get Bluesky notifications.

## SYNTAX

```yaml
Get-BskyNotification [[-Limit] <Int32>] -Credential <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve Bluesky notifications. You can limit the number of notifications returned up to 100. The default is 50. The default output uses a custom format file to display the notifications. The Account name is displayed as a hyperlink to the account's Bluesky profile. If the notification is a like, the emoji is a clickable link to the post that was liked.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-bskyNotification -Limit 5

Date               Account
----               -------
11/13/2024 8:51 AM ➡ Radu Bogdan
11/13/2024 8:42 AM ➡ Emanuel Palm
11/13/2024 8:34 AM ➡ Anthony Zoko
11/13/2024 8:23 AM ➡ robm82.bsky.social
11/13/2024 8:13 AM ➡ Jimmy Kumblad
```

The default output includes emojis and clickable links.

## PARAMETERS

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

### -Limit
Enter the number of notifications to retrieve between 1 and 100.
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

### PSBlueskyNotification

## NOTES

## RELATED LINKS

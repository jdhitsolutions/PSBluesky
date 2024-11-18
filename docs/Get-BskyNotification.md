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
Get-BskyNotification [[-Limit] <Int32>] [-Filter <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve Bluesky notifications. You can limit the number of notifications returned up to 100. The default is 50. There is a filtering option based on type, but the filtering is applied after the specified number of notifications are retrieved. The parameter is a convenience so that you don't need to construct an expression using Where-Object.

The default output uses a custom format file to display the notifications. The Account name is displayed as a hyperlink to the account's Bluesky profile. Referenced text should also be clickable. The default output includes emojis.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyNotification -Limit 5

Date               Account                    Subject
----               -------                    -------
11/13/2024 1:36 PM ➡  mscommunity.bsky.social
11/13/2024 1:24 PM ➡  Oscar
11/13/2024 1:18 PM ➡  dirteam.bsky.social
11/13/2024 1:04 PM ➡  Hoang Chu
11/13/2024 1:01 PM 👍 Madhu PERERA            I have published v1.2.0 of the
                                              PSBluesky module to the
                                              #PowerShell Gallery. Run
                                              Open-BskyHelp to read the help PDF
```

The default output includes emojis and clickable links. Long account names will be truncated in the formatted output.

### Example 2

```powershell
PS C:\> Get-BskyNotification -Limit 10 -Filter Follow

Date               Account                    Subject
----               -------                    -------
11/14/2024 9:12 AM ➡  Master Packager
11/14/2024 9:06 AM ➡  Reed M. Wiedower (CT...
11/14/2024 8:34 AM ➡  foontzoot 🇨🇦
11/14/2024 8:19 AM ➡  Hanna
11/14/2024 7:52 AM ➡  Gavin Ashton
11/14/2024 6:58 AM ➡  Michel Zehnder
11/14/2024 5:59 AM ➡  handle.invalid
11/14/2024 5:48 AM ➡  lsdima.bsky.social
11/14/2024 5:32 AM ➡  romanoj.bsky.social
```

Filter the notifications to only show Follow notifications from the last 10 notifications.

## PARAMETERS

### -Limit

Enter the number of notifications to retrieve between 1 and 100.
Default is 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Enter the type of notifications to retrieve. Default is All.
Possible values are "Like","Follow","Repost","Mention", and "Reply".

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyNotification

## NOTES

## RELATED LINKS
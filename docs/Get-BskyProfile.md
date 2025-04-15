---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/getbskyprofile
schema: 2.0.0
---

# Get-BskyProfile

## SYNOPSIS

Get a Bluesky profile.

## SYNTAX

```yaml
Get-BskyProfile [[-UserName] <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve a Bluesky profile. The default will be your profile based on the credential you used to start your Bluesky session, but you can get any profile if you know the user name. The user name is case-sensitive. The default output includes clickable links.

Note the the Followers property may not be 100% accurate. This counter may not properly reflect accounts that have stopped following you. The way that Bluesky is handling bot accounts may also affect this count. To get a true picture of your followers, use Get-BskyFollowers.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyProfile

Jeff Hicks [jdhitsolutions.com]

PowerShell Author/Teacher/MVP/Guide ✍️
Prof. PowerShell Emeritus 🎓
Grizzled and grumpy IT Pro - https://jdhitsolutions.github.io/
🎼Amateur composer - https://musescore.com/user/26698536
Wine drinker 🍷🐶 and dog lover


Created            Posts Followers Following Lists
-------            ----- --------- --------- -----
5/21/2023 10:44 AM  1230      1994       415     2
```

The default output includes clickable links.

### Example 2

```powershell
PS C:\> Get-BskyProfile jsnover.com

Jeffrey Snover [jsnover.bsky.social]

PowerShell inventor, Reader, Science & Geopolitics geek, Google Distinguished Engineer


Created           Posts Followers Following Lists
-------           ----- --------- --------- -----
5/1/2023 10:14 AM   210      2747       660     0
```

You can get any profile if you know the user name.

## PARAMETERS

### -UserName

Enter the profile or user name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Profile,Handle

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

### PSBlueskyProfile

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Find-BskyUser](Find-BskyUser.md)

[Get-BskyFollowers](Get-BskyFollowers.md)

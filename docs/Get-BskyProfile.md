---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyProfile

## SYNOPSIS

Get a Bluesky profile

## SYNTAX

```yaml
Get-BskyProfile [[-UserName] <String>] -Credential <PSCredential> [<CommonParameters>]
```

## DESCRIPTION

Use this command to retrieve a Bluesky profile. The default will be your profile based on the credential you use, but you can get any profile if you know the user name. The user name is case-sensitive. The default output includes clickable links.

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


Created               Posts Followers Following Lists
-------               ----- --------- --------- -----
5/21/2023 10:44:48 AM   544       322       177     0
```

The default output includes clickable links. This example assumes the credential has been set in $PSDefaultParameterValues.

### Example 2

```powershell
PS C:\> Get-BskyProfile jsnover.bsky.social

Jeffrey Snover [jsnover.bsky.social]

PowerShell inventor, Reader, Science & Geopolitics geek, Google Distinguished Engineer


Created              Posts Followers Following Lists
-------              ----- --------- --------- -----
5/1/2023 10:14:33 AM    32       592        26     0
```

You can get any profile if you know the user name.

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

### -UserName

Enter the profile or user name.

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

### PSBlueskyProfile

## NOTES

## RELATED LINKS

[Find-BskyUser](Find-BskyUser.md)

---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/newbskyfollow
schema: 2.0.0
---

# New-BskyFollow

## SYNOPSIS

Follow a Bluesky user.

## SYNTAX

```yaml
New-BskyFollow [[-UserName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to follow a Bluesky user. The user will get a notification that you have followed them.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-BskyFollow thedavecarroll.com -Verbose
https://bsky.app/profile/did:plc:rlwd5iajr3btl5e7gyvfwk67
```

The output is a link to the followed user's profile.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### String

## NOTES

## RELATED LINKS

[Get-BskyProfile](Get-BskyProfile.md)

[Get-BskyFollowers](Get-BskyFollowers.md)

[Get-BskyFollowing](Get-BskyFollowing.md)

[Remove-BskyFollow](Remove-BskyFollow.md)

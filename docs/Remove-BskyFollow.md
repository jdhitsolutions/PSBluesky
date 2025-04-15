---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/removebskyfollow
schema: 2.0.0
---

# Remove-BskyFollow

## SYNOPSIS

Unfollow a Bluesky user.

## SYNTAX

### User (Default)

```yaml
Remove-BskyFollow [[-UserName] <String>] [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DID

```yaml
Remove-BskyFollow [[-DID] <String>] [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Use this command to unfollow a Bluesky user. You can specify the account by username or DID. If you don't follow the user, you will receive a warning message. The user will not see any notification that you have un-followed them.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-BskyFollow thedavecarroll.com
```

The default behavior is no output.

### Example 2

```powershell
PS C:\> Remove-BskyFollow thedavecarroll.com -passthru
cid                                                         rev
---                                                         ---
bafyreigmtawteltd6lqsj5kpp7czhbygnooyx6j6xacgh7cjvofclqerxa 3lfnfgueedi2k
```

Pass the API result to the pipeline.

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

### -DID

Enter the profile DID

```yaml
Type: String
Parameter Sets: DID
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserName

Enter the profile or user name.

```yaml
Type: String
Parameter Sets: User
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

### -Passthru

```yaml
Type: SwitchParameter
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

### System.String

## OUTPUTS

### PSObject

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyProfile](Get-BskyProfile.md)

[Get-BskyFollowers](Get-BskyFollowers.md)

[Get-BskyFollowing](Get-BskyFollowing.md)

[New-BskyFollow](New-BskyFollow.md)

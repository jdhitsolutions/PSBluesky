---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Block-BskyUser

## SYNOPSIS

Block a Bluesky user account.

## SYNTAX

### User (Default)

```yaml
Block-BskyUser [[-UserName] <String>] [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Input

```yaml
Block-BskyUser [[-InputObject] <Object>] [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Use this account to block a Bluesky user account. You can specify an account username or pipe a profile object to the function.

## EXAMPLES

### Example 1

```powershell
PS C:\> Block-BskyUser -UserName "PooBar1234.bsky.social"
```


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

### -InputObject

A Bluesky profile object.

```yaml
Type: Object
Parameter Sets: Input
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Passthru

Write the API response to the pipeline.

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

### -UserName

Enter the profile or user name.

```yaml
Type: String
Parameter Sets: User
Aliases: Profile

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Object

## OUTPUTS

### None

### PSObject

## NOTES

## RELATED LINKS

[Unblock-BskyUser](Unblock-BskyUser.md)

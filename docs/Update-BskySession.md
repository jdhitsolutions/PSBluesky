---
external help file: PSBluesky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Update-BskySession

## SYNOPSIS

Refresh the Bluesky session token.

## SYNTAX

```yaml
Update-BskySession [-RefreshToken] <String> [<CommonParameters>]
```

## DESCRIPTION

You can use this command if you want to manually refresh your Bluesky access token. Module commands should automatically attempt to refresh it if the age is over 60 minutes. You should rarely need to call this command as the session token is refreshed automatically every 15 minutes.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskySession | Update-BskySession

   User: jdhitsolutions.com

Active AccessToken             RefreshToken            Age
------ -----------             ------------            ---
True   eyJ0eXAiOiJhdCtqd3Qi... eyJ0eXAiOiJyZWZyZXNo... 00:00:00.0072880
```

If you see an error message about an expired session, this is the best command to run. If you can't refresh the session, you'll need to re-authenticate, start a new session by running Start-BskySession.

## PARAMETERS

### -RefreshToken

The refresh token from the Bluesky session object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSBlueskySession

## NOTES

## RELATED LINKS

[Start-BskySession](Start-BSkySession.md)

[Get-BskySession](Get-BskySession.md)

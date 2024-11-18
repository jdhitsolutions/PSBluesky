---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version:
schema: 2.0.0
---

# Get-BskyModuleInfo

## SYNOPSIS

Get a summary of the PSBlueSky module.

## SYNTAX

```yaml
Get-BskyModuleInfo [<CommonParameters>]
```

## DESCRIPTION

Use this command to get a summary of the PSBlueSky module showing functions, aliases and a help synopsis. The default output includes clickable links to online command help and the module's GitHub repository.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BskyModuleInfo

   Module: PSBlueSky [v2.0.0]

Name                 Alias               Synopsis
----                 -----               --------
Add-BskyImage                            Upload an image to Bluesky
Find-BskyUser        bsu                 Search for Bluesky user accounts
Get-BskyFeed         bsfeed              Get your Bluesky feed
Get-BskyFollowers    bsfollower          Get your Bluesky followers
Get-BskyFollowing    bsfollow            Get a list of Bluesky accounts that
                                         you follow
Get-BskyModuleInfo                       Get a summary of the PSBlueSky module.
Get-BskyNotification bsn                 Get Bluesky notifications.
Get-BskyProfile      bsp                 Get a Bluesky profile
Get-BskySession                          Show your current Bluesky session.
Get-BskyTimeline     bst                 Get your Bluesky timeline
New-BskyPost         skeet               Create a Bluesky post
Open-BskyHelp        bshelp              Open the PSBluesky help document
Start-BSkySession                        Start a new Bluesky session
Update-BskySession   Refresh-BskySession Refresh the Bluesky session token
```

The default output includes clickable hyperlinks.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBlueskyModuleInfo

## NOTES

## RELATED LINKS

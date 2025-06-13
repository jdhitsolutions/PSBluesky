---
external help file: PSBlueSky-help.xml
Module Name: PSBlueSky
online version: https://jdhitsolutions.com/yourls/a58d5e
schema: 2.0.0
---

# Find-BskyPost

## SYNOPSIS

Find Bluesky posts.

## SYNTAX

```yaml
Find-BskyPost [-Query] <String> [-Limit <Int32>] [-UserName <String>] [-Language <String>] [-Since <DateTime>] [<CommonParameters>]
```

## DESCRIPTION

This command uses the Bluesky API to find posts that match a given query. You can specify a keyword or phrase and search all posts or limit the search to a particular user. The API does not support searching tags and the results are not guaranteed to be complete or immediately up-to-date. This command should be considered EXPERIMENTAL and may change in future releases or be removed entirely.

This command was added in v2.6.0.

## EXAMPLES

### Example 1

```powershell
PS C:\> Find-BskyPost -query "PSConfeu" -Since "4/1/2025"

Date                Liked Replied Reposted Quoted
----                ----- ------- -------- ------
4/8/2025 7:02:55 PM     0       2        0      0


Patch My PC [patchmypc.com]

They're pretty great, right? We won't make it to PSConfEU this year, but we've got several other conferences on the
lineup ➡️ patchmypc.com/events?utm_c...

Will you be at any of these?


Date                Liked Replied Reposted Quoted
----                ----- ------- -------- ------
4/8/2025 2:38:53 PM     3       1        0      0

Thorsten Butz 🎗️ [thorsten.butz.io]

So that thi is clear, @patchmypc.com : better bring some ducks to @psconfeu , I want one of these ! 🐥


Date                Liked Replied Reposted Quoted
----                ----- ------- -------- ------
4/5/2025 5:12:28 AM 17          0        0      0

Rob Sewell He/Him [robsewell.com]

Riding in Mallorca with @tracisewell.com and my @psconf.eu shirt on


Date                Liked Replied Reposted Quoted
----                ----- ------- -------- ------
4/3/2025 4:35:57 PM     0       0        0      0

Cory Knox (corbob) [coryknox.dev]

It's not what you're looking for per se, but there was a psconfeu video from a few years back where someone demoed
their nvim setup.


Date                Liked Replied Reposted Quoted
----                ----- ------- -------- ------
4/2/2025 6:15:03 AM     0       0        0      0

 [JeffHicks.techhub.social.ap.brid.gy]

I am very excited to return to Sweden this summer for #PSConfEU. Looking forward to Swedish summer nights with my
European and Scandinavian #PowerShell family. I hope to see you there. Skål! https://psconf.eu/
```

Do not attempt to search for a tag like #PSConfEU. The API will treat it as a bad request. The
output is formatted with links to the user profile and the message.

### Example 2

```powershell
PS C:\> Find-BskyPost -query "PSPodcast" -UserName jdhitsolutions.com

Date                 Liked Replied Reposted Quoted
----                 ----- ------- -------- ------
4/12/2025 3:42:22 PM 16          3        6      3


Jeff Hicks [jdhitsolutions.com]

The first release of the PSPodcast #PowerShell module is now in the PowerShell Gallery. It requires PS and the
pwshSpectreConsole module. I recommend looking at the project's README file.  This is designed for interactive fun.
github.com/jdhitsolutio...  /cc @andrewpla.tech


Date                 Liked Replied Reposted Quoted
----                 ----- ------- -------- ------
4/11/2025 7:06:56 PM 12          1        0      0

Jeff Hicks [jdhitsolutions.com]

Planning on publishing the first release of the PSPodcast #PowerShell module over the weekend. I'll announce it here
when that happens.
```

Searching for posts by a specific user.

### Example 3

```powershell
PS C:\> Find-BskyPost -query "*" -UserName jdhitsolutions.com
```

You can find all posts by a specific user with a wildcard query. You can return between 1 and 100 posts. The default is 50.

## PARAMETERS

### -Language

Filter by a language.
The default is English (en).

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

### -Limit

Enter the number of posts to retrieve between 1 and 100.
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

### -Query

Enter a search term or text. If you specify a username, you can use a wildcard query to find all posts by that user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since

Filter by posts since a specific date and time.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName

Filter by a username.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Profile, Handle

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

### PSBlueskyFeedItem

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-BskyFeed](Get-BskyFeed.md)

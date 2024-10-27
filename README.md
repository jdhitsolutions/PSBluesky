# PSBluesky

__This module is a work in progress. Expect things to change__

This PowerShell module is a set of PowerShell functions designed to let you interact with Bluesky API from PowerShell. Technically, the module commands are wrappers around the [atproto protocols](https://docs.bsky.app/docs/category/http-reference).

The module is written for PowerShell 7, although it might work as written in Windows PowerShell or with minimal changes.

## Authentication

In order to send data, you must authenticate. The `Get-PSBlueskyAccessToken` function will retrieve an access token. You shouldn't need to call this command directly. The other module commands will call it and pass the authentication token as needed. Technically, the token has a time limit and it could be re-used. But it is just as easy to get a token with each request since it is assumed you will be using the module commands intermittently.

You will need to create a PSCredential object with your Bluesky username and password. For automation purposes, you can use the Secrets management module to store your credential. Write your own code to retrieve the credential and pass it to the module commands. You might want to use `PSDefaultParameterValues` to set the credential for all commands.

```powershell
$PSDefaultParameterValues['*-PSBluesky*:Credential'] = $BlueskyCredential
```

## Posting

Use `New-PSBlueskyPost` or its alias `skeet` to post a message to Bluesky. There are parameter to include an image. If you include an image, the `New-PSBlueskyPost` command will call `Add-PSBlueskyImage` to upload the image. It is recommended that you included ALT text for the image.

```powershell
New-PSBlueskyPost -Message "Getting close to sharing my #PowerShell Bluesky code. I'm assuming a few of you are interested." -ImagePath C:\work\MsPowerShell.jpg -ImageAlt "Ms. PowerShell" -Verbose
```

The output is a URL to the post.

If your message contains a URL, it will be converted to a clickable link. Make sure your link is surrounded by white space. Markdown formatted links are not supported, although it is on the wish list.

## Profiles

The module has a command to retrieve a Bluesky profile.

```powershell
Get-PSBlueskyProfile jdhitsolutions.com
```

The module uses a custom format file.

![A Bluesky profile](images/bsky-profile.png)

The user's profile name should be a clickable link.

## Followers

You can retrieve a list of your followers

```powershell
Get-PSBlueskyFollowers -Limit 2
```

![Bluesky followers](images/bsky-follower.png)

The custom formatting includes a clickable link to the follower's profile if running in Windows Terminal or a console that supports hyperlinks.

You can pipe the follower object to `Get-PSBlueskyProfile` to retrieve more information.

```powershell
PS C:\>$f= Get-PSBlueskyFollowers
PS C:\> $f[12] | Get-PSBlueskyProfile

Jess Pomfret [jpomfret.bsky.social]

Database Engineer with a passion for automation, proper football and fitness.
She/Her.


Created              Posts Followers Following Lists
-------              ----- --------- --------- -----
8/14/2023 3:58:44 PM   125       236       157     1
```

You can retrieve between 1 and 100 followers. I don't know if there is a way to enumerate or page through all followers.

## Feed

Use `Get-PSBlueskyFeed` to retrieve the latest posts from your feed. You can query for 1 to 100.

```powershell
Get-PSBlueskyFeed -Limit 3
```
The object output has a custom format file.

![Bluesky feed](images/bsky-feed.png)

The output includes clickable links to the the author, which might be different than you if reposting, and the post.

The current behavior is to get posts and replies.

## Information and Troubleshooting

The commands in this module should write the raw response from the API request to the Information stream.

![Information stream](images/bsky-information.png)

The output will be an object.

```powershell
PS C:\Scripts\PSBluesky> $v.MessageData | Select-Object did,handle,*count

did            : did:plc:ohgsqpfsbocaaxusxqlgfvd7
handle         : jdhitsolutions.com
followersCount : 322
followsCount   : 177
postsCount     : 543
```

## Roadmap

I have a short list of items to finish before this can be published to the PowerShell Gallery.

- help documentation
- support Markdown formatted links in posts
- localize verbose and other messaging

If you are testing the module and think you've found a bug, please post an [Issue](https://github.com/jdhitsolutions/PSBlueSky/issues). For all other topics and questions, please use the [Discussions](https://github.com/jdhitsolutions/PSBlueSky/discussions) feature.

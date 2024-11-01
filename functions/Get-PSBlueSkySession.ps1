Function Get-BskySession {
    [cmdletbinding()]
    [OutputType("PSBlueskySession")]
    Param()

    if ($script:BSkySession) {
        $script:BSkySession
    }
    else {
        Write-Warning 'No Existing Bluesky session found. Have you created an access token or run a module command like Get-BskyFeed?'
    }
}
Function Get-BskySession {
    [cmdletbinding()]
    [OutputType("PSBlueskySession")]
    Param()

    if ($script:BSkySession) {
        $script:BSkySession
    }
    else {
        Write-Warning 'No Existing Bluesky session found. Have you logged in and created a session?'
    }
}
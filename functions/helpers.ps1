#these are private helper functions

Function _newFacetLink {
    # https://docs.bsky.app/docs/advanced-guides/post-richtext
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory, HelpMessage = 'The Bluesky message with the links')]
        [string]$Message,
        [Parameter(Mandatory, HelpMessage = 'The text of the link')]
        [string]$Text,
        [Parameter(Mandatory, HelpMessage = 'The URI of the link')]
        [string]$Uri
    )

    Write-Verbose "[Helper] Creating a new facet link for $uri [$Text] in '$Message'"
    #the comparison test is case-sensitive
    if (([regex]$Text).IsMatch($Message)) {
        #properties of the facet object are also case-sensitive
        $m = ([regex]$Text).match($Message)
        [PSCustomObject]@{
            index    = [ordered]@{
                byteStart = $m.index
                byteEnd   = $m.value.length+$m.length+1
            }
            features = @(
                [PSCustomObject]@{
                    '$type' = 'app.bsky.richtext.facet#link'
                    uri     = $Uri
                }
            )
        }
    }
    else {
        Write-Warning "The text $Text was not found in the message $Message."
    }
}

Function _convertAT {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory, HelpMessage = 'The AT string to convert')]
        [ValidatePattern("^at://")]
        [string]$at
    )

    #at://did:plc:qrllvid7s54k4hnwtqxwetrf/app.bsky.feed.post/3l7e5jvorof2t
    $split = $at -split '/' | where { $_ -match '\w' }
    #this part might need to change in the future depending on the type of link
    $publicUri = 'https://bsky.app/profile/'
    $publicUri += '{0}/post/{1}' -f $split[1], $split[-1]
    $publicUri
}



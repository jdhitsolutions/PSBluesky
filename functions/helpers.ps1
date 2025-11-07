#these are private helper functions

function _newFacetLink {
    # https://docs.bsky.app/docs/advanced-guides/post-richtext
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, HelpMessage = 'The Bluesky message with the links')]
        [string]$Message,
        [Parameter(Mandatory, HelpMessage = 'The text of the link')]
        [string]$Text,
        [Parameter(HelpMessage = 'The URI of the link')]
        [string]$Uri,
        [Parameter(HelpMessage = 'The DID of the mention')]
        [string]$DiD,
        [Parameter(HelpMessage = 'The Tag text')]
        [string]$Tag,
        [ValidateSet('link', 'mention', 'tag')]
        [string]$FacetType = 'link'
    )

    $PSDefaultParameterValues['_verbose:block'] = 'PRIVATE'
    _verbose -Message ($strings.NewFacet -f $FacetType, $Text, $Message)
    $feature = switch ($FacetType) {
        'link' {
            _verbose -Message ($strings.FacetLink -f $Uri)
            [PSCustomObject]@{
                '$type' = 'app.bsky.richtext.facet#link'
                uri     = $Uri
            }
        }
        'mention' {
            _verbose -Message ($strings.FacetMention -f $DID)
            [PSCustomObject]@{
                '$type' = 'app.bsky.richtext.facet#mention'
                did     = $DiD
            }
        }
        'tag' {
            _verbose -Message ($strings.FacetTag -f $Tag)
            [PSCustomObject]@{
                '$type' = 'app.bsky.richtext.facet#tag'
                tag     = $Tag
            }
        }
    }

    if ($text -match '\[|\]|\(\)') {
        _verbose -Message $strings.RxEscape
        $text = [regex]::Escape($text)
    }
    #the comparison test is case-sensitive
    if (([regex]$Text).IsMatch($Message)) {
        #properties of the facet object are also case-sensitive
        $m = ([regex]$Text).match($Message)
        [PSCustomObject]@{
            index    = [ordered]@{
                byteStart = $m.index
                byteEnd   = ($m.length) + ($m.index)
            }
            features = @(
                $feature
            )
        }
    }
    else {
        Write-Warning ($strings.TextNotFound -f $Text, $Message)
    }
}

function _convertDidToAt {
    [cmdletbinding()]
    param(
        [parameter(Mandatory, HelpMessage = 'The DID to convert')]
        [ValidatePattern('^did:plc:')]
        [string]$did
    )

    #did:plc:qrllvid7s54k4hnwtqxwetrf
    $at = $did.replace('did:', 'at://')
    $at
}

function _convertAT {
    [cmdletbinding()]
    param(
        [parameter(Mandatory, HelpMessage = 'The AT string to convert')]
        [ValidatePattern('^at://')]
        [string]$at,

        [string]$type = 'profile'
    )

    #at://did:plc:qrllvid7s54k4hnwtqxwetrf/app.bsky.feed.post/3l7e5jvorof2t
    $split = $at -split '/' | Where-Object { $_ -match '\w' }

    if ($type -eq 'profile') {
        $publicUri = 'https://bsky.app/profile/'
        $publicUri += '{0}/post/{1}' -f $split[1], $split[-1]
    }
    elseif ($type -eq 'starter-pack') {
        $publicUri = 'https://bsky.app/starter-pack/'
        $publicUri += '{0}/{1}' -f $split[1], $split[-1]
    }
    else {
        Write-Error "Invalid type $type encountered converting AT to URL."
    }

    $publicUri
}

function _getPostText {
    [cmdletbinding()]
    param (
        [string]$AT,
        [hashtable]$Headers
    )
    if ($AT) {
        $apiUrl = "$PDSHost/xrpc/app.bsky.feed.getPosts?uris=$at"
        $r = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
        $r.posts.record.text
    }
}

function _newSessionObject {
    <#
Convert the API response into a structured and type object

did             : did:plc:ohgsqpfsbocaaxusxqlgfvd7
didDoc          : @{@context=System.Object[]; id=did:plc:ohgsqpfsbocaaxusxqlgfvd7; alsoKnownAs=System.Object[];
                  verificationMethod=System.Object[]; service=System.Object[]}
handle          : jdhitsolutions.com
email           : jhicks@jdhitsolutions.com
emailConfirmed  : True
emailAuthFactor : False
accessJwt       : eyJ0eXAiOiJhdCtqd3QiLCJhbGciOiJFUzI1NksifQ.eyJzY29wZSI...
refreshJwt      : eyJ0eXAiOiJyZWZyZXNoK2p3dCIsImFsZyI6IkVTMjU2SyJ9.eyJz...
active          : True
Date            : 10/29/2024 9:56:40 AM
Age             : 01:09:58.6486840
#>

    [CmdletBinding()]
    param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The Bluesky session object',
            ValueFromPipeline
        )]
        [object]$InputObject
    )
    begin {
        #not used
    }
    process {
        [PSCustomObject]@{
            PSTypeName     = 'PSBlueskySession'
            Handle         = $InputObject.handle
            Email          = $InputObject.email
            Active         = $InputObject.active
            AccessJwt      = $InputObject.accessJwt
            RefreshJwt     = $InputObject.refreshJwt
            DiD            = $InputObject.did
            DidDoc         = $InputObject.didDoc
            Date           = $InputObject.Date
            LoggingEnabled = $InputObject.LoggingEnabled
            LogFile        = $InputObject.LogFile
        }
    } #process
    end {
        #11 Nov  2024 Move these definitions to the root module
        <#
        Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName UserName -Value handle -Force
        Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName AccessToken -Value AccessJwt -Force
        Update-TypeData -TypeName 'PSBlueskySession' -MemberType AliasProperty -MemberName RefreshToken -Value RefreshJwt -Force
        Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.Date } -Force
        Update-TypeData -TypeName 'PSBlueskySession' -MemberType ScriptMethod -MemberName Refresh -Value {Update-BskySession -RefreshToken $this.RefreshJwt} -Force
        #>
    }
}

function _CreateSession {
    #there is an API limit of 300 per day for this endpoint
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    $PSDefaultParameterValues['_verbose:block'] = 'PRIVATE'
    #Create a logon session
    $headers = @{
        'Content-Type' = 'application/json'
    }

    $apiUrl = "$PDSHOST/xrpc/com.atproto.server.createSession"
    $body = @{
        identifier = $Credential.UserName
        password   = $Credential.GetNetworkCredential().Password
    } | ConvertTo-Json

    _verbose -Message ($strings.NewSession -f $credential.UserName)

    $splat = @{
        Uri         = $apiUrl
        Method      = 'Post'
        Headers     = $headers
        Body        = $Body
        ErrorAction = 'Stop'
    }
    try {
        # 11 Nov 2024 -create a synchronized hashtable and use a background runspace
        # to update the session every 15 minutes

        # 16 Jan 2025 - increase the session refresh time to 60 minutes to minimize
        # the number of API calls

        $r = Invoke-RestMethod @splat
        _newLogData -apiUrl $apiUrl -command $MyInvocation.MyCommand | _updateLog
        _verbose -Message $strings.DefineSyncHash
        <#         $script:BskySession = [hashtable]::Synchronized(@{
                Handle         = $r.handle
                Email          = $r.email
                Active         = $r.active
                AccessJwt      = $r.accessJwt
                RefreshJwt     = $r.refreshJwt
                DiD            = $r.did
                DidDoc         = $r.didDoc
                Date           = Get-Date
                LoggingEnabled = $global:bskyLoggingEnabled
                LogFile        = $global:bskyLogFile
            }) #>
        $script:BskySession.Handle = $r.handle
        $script:BskySession.Email = $r.email
        $script:BskySession.Active = $r.active
        $script:BskySession.AccessJwt = $r.accessJwt
        $script:BskySession.RefreshJwt = $r.refreshJwt
        $script:BskySession.DiD = $r.did
        $script:BskySession.DidDoc = $r.didDoc
        $script:BskySession.Date = Get-Date

        # DELETE?
        #script:accessJwt = $script:BskySession.accessJwt
        #script:refreshJwt = $script:BskySession.refreshJwt

        $script:BskySession | _newSessionObject

        #create a runspace to update the session every 60 minutes
        _verbose -message $strings.NewRunspace
        $newRunspace = [RunspaceFactory]::CreateRunspace()
        $newRunspace.ApartmentState = 'STA'
        $newRunspace.ThreadOptions = 'ReuseThread'
        $newRunspace.Open()
        $newRunspace.SessionStateProxy.SetVariable('BskySession', $script:BskySession)

        $script:PSCmd = [PowerShell]::Create().AddScript({
                $PDSHOST = 'https://bsky.social'
                $i = 0
                function _newLogData {
                    [CmdletBinding()]
                    param(
                        [Parameter(ValueFromPipeline, Mandatory)]
                        [string]$apiUrl,
                        [Parameter(Mandatory)]
                        [string]$Command
                    )

                    [regex]$rx = '((app)|(com)|(chat))(\.\w+){3}'
                    $ep = $rx.match($apiUrl).value
                    [PSCustomObject]@{
                        Date     = Get-Date
                        PID      = $PID
                        Uri      = $apiUrl
                        Endpoint = $rx.match($apiUrl).value
                        Name     = $ep.split('.')[-1]
                        Command  = $command
                        Host     = $Host.Name
                    }
                }

                function _updateLog {
                    [CmdletBinding()]
                    param(
                        [Parameter(ValueFromPipeline, Mandatory)]
                        [object]$InputObject,
                        [string]$Path = $BskySession.LogFile
                    )
                    begin {
                        if ($BskySession.LoggingEnabled) {
                            $existing = [System.Collections.Generic.List[object]]::new()
                            #import existing data if found
                            if (Test-Path $Path) {
                                $existing.AddRange([object[]](Get-Content -Path $Path -Raw | ConvertFrom-Json))
                            }
                        } #if Logging
                    }
                    process {
                        if ($BskySession.LoggingEnabled) {
                            $existing.Add($InputObject)
                        }
                    }
                    end {
                        if ($BskySession.LoggingEnabled) {
                            $existing | ConvertTo-Json | Out-File -FilePath $Path -Force -Encoding utf8
                        }
                    }
                }
                #!!!!!!! MY DEBUG CODE
                # $debugFile = "d:\temp\debug.log"
                do {
                    $ts = New-TimeSpan -Start $BskySession.Date -End (Get-Date)
                    if ($ts.TotalMinutes -ge 60) {
                        $i++
                        #refresh
                        $headers = @{
                            Authorization  = "Bearer $($BskySession.refreshJwt)"
                            'Content-Type' = 'application/json'
                        }
                        $apiUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
                        try {
                            $splat = @{
                                Uri           = $apiUrl
                                Method        = 'Post'
                                Headers       = $headers
                                ErrorAction   = 'Stop'
                                ErrorVariable = 'e'
                            }
                            $r = Invoke-RestMethod @splat
                            _newLogData -apiUrl $apiUrl -command RunspaceRefreshSession | _updateLog
                            #!!!!!!! DEBUG CODE
                            # "[$((Get-Date).TimeOfDay)] Refreshing session" | Out-File -FilePath $debugFile -Append
                            # $r | Out-File -FilePath $debugFile -Append
                            #!!!!!!! DEBUG CODE
                            $BskySession.accessJwt = $r.accessJwt
                            $BskySession.refreshJwt = $r.refreshJwt
                            $BskySession.Active = $r.active
                            $BskySession.Date = Get-Date
                            $BskySession['RunspaceOperation'] = $i
                        } #try
                        catch {
                            #!!!!!!! DEBUG CODE
                            #"[$(Get-Date)] Failed to authenticate or refresh the session. $($_.Exception.Message)" | out-file $debugFile -Append
                            #$e.message | out-file $debugFile -Append
                        } #catch
                    }
                    Start-Sleep -Seconds 60
                } while ($True)
                exit
            })

        $script:PSCmd.runspace = $newRunspace
        _verbose -Message $strings.StartRunspace
        [Void]($psCmd.BeginInvoke())

    } #try
    catch {
        throw $_
    }
    if ($null -eq $script:BskySession.accessjwt) {
        Write-Warning $strings.FailAuthenticate
    }
}

#a private function to display customized verbose messages
function _verbose {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Message,
        [string]$Block = 'PROCESS',
        [string]$Command
    )

    #Display each command name in a different color sequence
    if ($bskyPreferences.Contains($Command)) {
        [string]$ANSI = $bskyPreferences[$Command]
    }
    else {
        [string]$ANSI = $bskyPreferences['DefaultCommand']
    }

    $BlockString = $Block.ToUpper().PadRight(7, ' ')
    $Reset = "$([char]27)[0m"
    $ToD = (Get-Date).TimeOfDay
    $AnsiCommand = "$ANSI$($command)"
    $Italic = "$([char]27)[3m"
    if ($Host.Name -eq 'Windows PowerShell ISE Host') {
        #this code should never run in this module since it requires PowerShell 7
        $msg = '[{0:hh\:mm\:ss\:ffff} {1}] {2}-> {3}' -f $Tod, $BlockString, $Command, $Message
    }
    else {
        $msg = '[{0:hh\:mm\:ss\:ffff} {1}] {2}{3}-> {4} {5}{3}' -f $Tod, $BlockString, $AnsiCommand, $Reset, $Italic, $Message
    }
    #use the built-in Write-Verbose cmdlet
    Microsoft.PowerShell.Utility\Write-Verbose -Message $msg

}

function _previewPost {
    [CmdletBinding()]
    param($Body, $ImagePath, $ImageAlt)

    $post = $Body | ConvertFrom-Json
    $txt = $Post.record.text
    if ($Post.record.facets) {
        $script:pad = 0
        #sort the facets by start position
        $facets = $post.record.facets | Sort-Object { $_.index.byteStart }
        foreach ($f in $facets) {
            switch -regex ($f.features.'$type') {
                'link' {
                    #get the word from the facet boundaries
                    #Add the length of previous facets
                    $start = $f.index.byteStart + $script:pad
                    $end = ($f.index.byteEnd - 1) + $script:pad
                    $len = ($end - $start) + 1
                    $wd = $txt[$start..$end] -join ''
                    #   Write-Host "LINK: $wd [$start to $end] - $($script:pad)" -ForegroundColor yellow
                    $uri = $f.features.uri
                    $link = "$($PSStyle.Foreground.Cyan)$($PSStyle.FormatHyperLink($wd,$uri))$($PSStyle.Reset)"
                    #remove the word
                    $txt = $txt.Remove($start, $len)
                    #insert the formatted replacement
                    $txt = $txt.Insert($start, $link)
                    $script:pad = $script:pad + ($link.Length - $wd.length)
                }
                'tag' {
                    $start = $f.index.byteStart + $script:pad
                    $end = ($f.index.byteEnd - 1) + $script:pad
                    $len = ($end - $start) + 1
                    $wd = $txt[$start..$end] -join ''
                    #   Write-Host "TAG:  $wd [$start to $end] - $($script:pad)" -ForegroundColor yellow

                    $tag = "$($PSStyle.Foreground.BrightGreen)$wd$($PSStyle.Reset)"
                    $txt = $txt.Remove($start, $len)
                    #   write-Host "inserting $tag at $start" -ForegroundColor yellow
                    $txt = $txt.Insert($start, $tag)
                    $script:pad = $script:pad + ($tag.Length - $wd.length)
                }
                'mention' {
                    #get the word from the facet boundaries
                    #Add the length of previous facets
                    $start = $f.index.byteStart + $script:pad
                    $end = ($f.index.byteEnd - 1) + $script:pad
                    $len = ($end - $start) + 1
                    $wd = $txt[$start..$end] -join ''
                    #Write-Host "MENTION:  $wd [$start to $end] - $($script:pad)" -ForegroundColor yellow
                    $uri = "https://bsky.app/profile/$($f.features.did)"
                    $link = "$($PSStyle.Foreground.magenta)$($PSStyle.FormatHyperLink($wd,$uri))$($PSStyle.Reset)"
                    #remove the word
                    $txt = $txt.Remove($start, $len)
                    #insert the formatted replacement
                    $txt = $txt.Insert($start, $link)
                    $script:pad = $script:pad + ($link.Length - $wd.length)
                }
            } #switch

        } #foreach facet
    }

    #preview the message and image
    #insert a blank line before the text
    "`n$txt"
    Try {
        [void](Get-Command Get-SpectreImage -ErrorAction Stop)
        if ($ImagePath) {
            Get-SpectreImage $imagePath -Width 25 | Out-SpectreHost
        }
        if ($ImageAlt) {
            Write-SpectreHost "ALT: [italic]$imageAlt[/]" | Out-SpectreHost
        }
    }
    Catch {
        #ignore any errors
    }

}

#this is a test and trouble shooting function
function __GetBskyVar {
    [cmdletbinding()]
    [OutputType('None')]
    param()

    '**Script scope**'
    gv bsky* -Scope script

    "`n**Global scope**"
    gv bsky* -Scope global
}
######
# 4 Nov 2024 -moved this to a public function, Update-BskySession
<#
Function X_RefreshSession {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, HelpMessage = 'The refresh token')]
        [string]$RefreshToken
        )

        #Refresh a Bluesky session
        Write-Verbose "[$((Get-Date).TimeOfDay)] Refreshing a Bluesky logon session for $($script:BskySession.handle)"
        $headers = @{
            Authorization  = "Bearer $RefreshToken"
            'Content-Type' = 'application/json'
        }
        $apiUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
        Try {
            $script:BskySession = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -ErrorAction Stop | _newSessionObject

            $script:accessJwt = $script:BskySession.accessJwt
            $script:refreshJwt = $script:BskySession.refreshJwt
            #return the session
            $script:BskySession
        } #try
        Catch {
            Write-Warning "Failed to authenticate or refresh the session. $($_.Exception.Message)"
        }
    }

#>
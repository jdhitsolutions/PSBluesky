#these are private helper functions

Function _newFacetLink {
    # https://docs.bsky.app/docs/advanced-guides/post-richtext
    [CmdletBinding()]
    Param(
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
    $feature = Switch ($FacetType) {
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
                byteEnd   = ($m.value.length) + ($m.index)
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

Function _convertDidToAt {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory, HelpMessage = 'The DID to convert')]
        [ValidatePattern('^did:plc:')]
        [string]$did
    )

    #did:plc:qrllvid7s54k4hnwtqxwetrf
    $at = $did.replace('did:', 'at://')
    $at
}

Function _convertAT {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory, HelpMessage = 'The AT string to convert')]
        [ValidatePattern('^at://')]
        [string]$at
    )

    #at://did:plc:qrllvid7s54k4hnwtqxwetrf/app.bsky.feed.post/3l7e5jvorof2t
    $split = $at -split '/' | where { $_ -match '\w' }
    #this part might need to change in the future depending on the type of link
    $publicUri = 'https://bsky.app/profile/'
    $publicUri += '{0}/post/{1}' -f $split[1], $split[-1]
    $publicUri
}
function _getPostText {
    [cmdletbinding()]
    param (
        [string]$AT,
        [hashtable]$Headers
    )
    if ($AT) {
        $url = "$script:PDSHost/xrpc/app.bsky.feed.getPosts?uris=$at"
        $r = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
        $r.posts.record.text
    }
}

Function _newSessionObject {
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
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The Bluesky session object',
            ValueFromPipeline
        )]
        [object]$InputObject
    )
    Begin {
        #not used
    }
    Process {
        [PSCustomObject]@{
            PSTypeName = 'PSBlueskySession'
            Handle     = $InputObject.handle
            Email      = $InputObject.email
            Active     = $InputObject.active
            AccessJwt  = $InputObject.accessJwt
            RefreshJwt = $InputObject.refreshJwt
            DiD        = $InputObject.did
            DidDoc     = $InputObject.didDoc
            Date       = $InputObject.Date
        }
    } #process
    End {
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

Function _CreateSession {
    #there is an API limit of 300 per day for this endpoint
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, HelpMessage = 'A PSCredential with your Bluesky username and password')]
        [PSCredential]$Credential
    )

    $PSDefaultParameterValues['_verbose:block'] = 'PRIVATE'
    #Create a logon session
    $headers = @{
        'Content-Type' = 'application/json'
    }

    $LogonURL = "$PDSHOST/xrpc/com.atproto.server.createSession"
    $body = @{
        identifier = $Credential.UserName
        password   = $Credential.GetNetworkCredential().Password
    } | ConvertTo-Json

    _verbose -Message ($strings.NewSession -f $credential.UserName)

    $splat = @{
        Uri         = $LogonURL
        Method      = 'Post'
        Headers     = $headers
        Body        = $Body
        ErrorAction = 'Stop'
    }
    Try {
        # 11 Nov 2024 -create a synchronized hashtable and use a background runspace
        # to update the session every 15 minutes

        $r = Invoke-RestMethod @splat
        _verbose -Message $strings.DefineSyncHash
        $script:BSkySession = [hashtable]::Synchronized(@{
                Handle     = $r.handle
                Email      = $r.email
                Active     = $r.active
                AccessJwt  = $r.accessJwt
                RefreshJwt = $r.refreshJwt
                DiD        = $r.did
                DidDoc     = $r.didDoc
                Date       = Get-Date
            })

        $script:accessJwt = $script:BSkySession.accessJwt
        $script:refreshJwt = $script:BSkySession.refreshJwt

        $script:BSkySession | _newSessionObject

        #create a runspace to update the session every 15 minutes
        _verbose -message $strings.NewRunspace
        $newRunspace = [RunspaceFactory]::CreateRunspace()
        $newRunspace.ApartmentState = 'STA'
        $newRunspace.ThreadOptions = 'ReuseThread'
        $newRunspace.Open()
        $newRunspace.SessionStateProxy.SetVariable('BSkySession', $script:BSkySession)

        $script:PSCmd = [PowerShell]::Create().AddScript({
                $PDSHOST = 'https://bsky.social'
                $i = 0
                #!!!!!!! MY DEBUG CODE
                # $debugFile = "d:\temp\debug.log"
                Do {
                    $ts = New-TimeSpan -Start $BSkySession.Date -End (Get-Date)
                    if ($ts.TotalMinutes -ge 15) {
                        $i++
                        #refresh
                        $headers = @{
                            Authorization  = "Bearer $($BSkySession.refreshJwt)"
                            'Content-Type' = 'application/json'
                        }
                        $RefreshUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
                        Try {
                            $splat = @{
                                Uri           = $RefreshUrl
                                Method        = 'Post'
                                Headers       = $headers
                                ErrorAction   = 'Stop'
                                ErrorVariable = 'e'
                            }
                            $r = Invoke-RestMethod @splat
                            #!!!!!!! DEBUG CODE
                            # "[$((Get-Date).TimeOfDay)] Refreshing session" | Out-File -FilePath $debugFile -Append
                            # $r | Out-File -FilePath $debugFile -Append
                            #!!!!!!! DEBUG CODE
                            $BSkySession.accessJwt = $r.accessJwt
                            $BSkySession.refreshJwt = $r.refreshJwt
                            $BSkySession.Active = $r.active
                            $BSkySession.Date = Get-Date
                            $BsKySession['RunspaceOperation'] = $i
                        } #try
                        Catch {
                            #!!!!!!! DEBUG CODE
                            #"[$(Get-Date)] Failed to authenticate or refresh the session. $($_.Exception.Message)" | out-file $debugFile -Append
                            #$e.message | out-file $debugFile -Append
                        } #catch
                    }
                    Start-Sleep -Seconds 60
                } While ($True)
                Exit
            })

        $script:PSCmd.runspace = $newRunspace
        _verbose -Message $strings.StartRunspace
        [Void]($psCmd.BeginInvoke())

    } #try
    Catch {
        throw $_
    }
    if ($null -eq $script:accessJwt) {
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
        Write-Verbose "[$((Get-Date).TimeOfDay)] Refreshing a Bluesky logon session for $($script:BSkySession.handle)"
        $headers = @{
            Authorization  = "Bearer $RefreshToken"
            'Content-Type' = 'application/json'
        }
        $RefreshUrl = "$PDSHost/xrpc/com.atproto.server.refreshSession"
        Try {
            $script:BSkySession = Invoke-RestMethod -Uri $RefreshUrl -Method Post -Headers $headers -ErrorAction Stop | _newSessionObject

            $script:accessJwt = $script:BSkySession.accessJwt
            $script:refreshJwt = $script:BSkySession.refreshJwt
            #return the session
            $script:BSkySession
        } #try
        Catch {
            Write-Warning "Failed to authenticate or refresh the session. $($_.Exception.Message)"
        }
    }

#>
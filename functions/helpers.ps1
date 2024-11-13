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

    Write-Verbose "[$((Get-Date).TimeOfDay) PRIVATE] Creating a new facet link for $uri [$Text] in '$Message'"
    if ($text -match "\[|\]|\(\)") {
        Write-Verbose "[Helper] Regex Escaping the text"
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

    #Create a logon session
    $headers = @{
        'Content-Type' = 'application/json'
    }

    $LogonURL = "$PDSHOST/xrpc/com.atproto.server.createSession"
    $body = @{
        identifier = $Credential.UserName
        password   = $Credential.GetNetworkCredential().Password
    } | ConvertTo-Json
    Write-Verbose "[$((Get-Date).TimeOfDay) PRIVATE] Creating a Bluesky logon session for $($Credential.UserName)"

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
        $newRunspace =[RunspaceFactory]::CreateRunspace()
        $newRunspace.ApartmentState = "STA"
        $newRunspace.ThreadOptions = "ReuseThread"
        $newRunspace.Open()
        $newRunspace.SessionStateProxy.SetVariable("BSkySession",$script:BSkySession)

        $script:PSCmd = [PowerShell]::Create().AddScript({
            $PDSHOST = 'https://bsky.social'
            $i=0
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
                            Uri         = $RefreshUrl
                            Method      = 'Post'
                            Headers     = $headers
                            ErrorAction = 'Stop'
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
                        $BsKySession["RunspaceOperation"] = $i
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
        [Void]($psCmd.BeginInvoke())

        #$script:BSkySession = Invoke-RestMethod @splat | _newSessionObject
        #$script:accessJwt = $script:BSkySession.accessJwt
        #$script:refreshJwt = $script:BSkySession.refreshJwt

    } #try
    Catch {
        throw $_
    }
    if ($script:accessJwt) {
        $script:accessJwt
    }
    else {
        Write-Warning 'Failed to authenticate.'
    }
}

# 4 Nov 2024 -moved this to a public function, Update-BskySession
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
        $script:BSkySession = Invoke-RestMethod -Uri $RefreshUrl -Method Post -Headers $headers -errorAction Stop | _newSessionObject

        $script:accessJwt = $script:BSkySession.accessJwt
        $script:refreshJwt = $script:BSkySession.refreshJwt
        #return the session
        $script:BSkySession
    } #try
    Catch {
        Write-Warning "Failed to authenticate or refresh the session. $($_.Exception.Message)"
    }
}


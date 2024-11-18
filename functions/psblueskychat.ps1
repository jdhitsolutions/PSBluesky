
#https://docs.bsky.app/docs/api/chat-bsky-convo-list-convos
#https://docs.bsky.app/docs/api/chat-bsky-convo-get-convo
#https://docs.bsky.app/docs/api/chat-bsky-convo-get-convo
Function Get-BskyChatList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PDSHost,
        [Parameter(Mandatory = $true)]
        [string]$headers
    )
    $url = "$PDSHost/xrpc/chat.bsky.convo.getConvoList"
    $m = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -verbose
    $m.convos | Select ID,
    @{Name="Members";Expression={$_.members.DisplayName}},
    @{Name="LastSent";Expression={$_.lastMessage.sentAt.ToLocalTime()}},
    @{Name="LastMesssage";Expression={$_.lastMessage.text}}
}
Function Get-BskyChat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PDSHost,
        [Parameter(Mandatory = $true)]
        [string]$headers,
        [Parameter(Mandatory = $true)]
        [string]$convoId
    )
    $url = "$PDSHost/xrpc/chat.bsky.convo.getConvo?convoId=$convoId"
    $c = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -verbose
    $c.convo | Select ID,
    @{Name="Members";Expression={$_.members.DisplayName}},
    @{Name="LastMessage";Expression={$_.lastMessage.sentAt.ToLocalTime()}}
}

Function Send-BskyChatMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PDSHost,
        [Parameter(Mandatory = $true)]
        [string]$headers,
        [Parameter(Mandatory = $true)]
        [string]$convoId,
        [Parameter(Mandatory = $true)]
        [string]$message
    )
    $body = [PSCustomObject]@{
        convoId = $convoId
        message = @{
            text      = $message
        }
    } | ConvertTo-Json -Depth 3
    $url = "$PDSHost/xrpc/chat.bsky.convo.sendMessage"
    $post = Invoke-RestMethod -Uri $url -Method POST -Headers $headers  -Body $body
    $post
}
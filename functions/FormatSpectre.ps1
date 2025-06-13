Function Format-SpectreConsole {
    [cmdletbinding()]
    [Alias("fsc", "Format-Bsky")]
    [OutputType("Formatted SpectreConsole output")]
    Param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [PSObject]$InputObject,
        [Parameter(HelpMessage = "The color of the title text. Use a SpectreConsole color name.")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({[Spectre.Console.Color].GetProperties().name -contains $_})]
        [string]$TitleColor = "Gold1",
        [Parameter(HelpMessage = "The color of the table border. Use a SpectreConsole color name.")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({[Spectre.Console.Color].GetProperties().name -contains $_})]
        [string]$BorderColor = "SteelBlue1_1"
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        If (-Not (Get-Module pwshSpectreConsole -ListAvailable -OutVariable m)) {
            Write-Warning $strings.NoSpectreConsole
            Break
        }
        _verbose -message $strings.Starting
        _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
        _verbose -message ($strings.UsingHost -f $host.Name)
        _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
        _verbose -message ($strings.UsingModule -f $ModuleVersion)
        _verbose -message ($strings.UsingSpectre -f $m[0].Version)

        $process = $True
        $ModuleData = @()
    } # begin
    Process {
         $PSDefaultParameterValues['_verbose:block'] = 'Process'
        if ($Process) {
            $tName = ($InputObject[0].PSObject.TypeNames).where({ $_ -match "PSBluesky" })[0]
            _verbose ($strings.DetectedType -f $tName)
            Switch -regex ($tName) {
                'FeedItem|TimelinePost|LikedItem' {
                    foreach ($item in $InputObject) {
                        $data = @()
                        $data += "$($item.AuthorDisplay) ([$TitleColor link=$($item.author)]$($item.Author)[/])`n"
                        $data += "[italic link=$($item.url)]$($item.text)[/]`n"
                        If ($item.Thumbnail) {
                            #there may be multiple images in the thumbnail property
                            foreach ($img in $item.Thumbnail) {
                                $data += Get-SpectreImage -ImagePath $img -MaxWidth 20
                            }
                        }
                        If ($item.links.count -gt 0) {
                            $data += "`n[$BorderColor italic]Links:[/]`r"
                            $data += $item.links
                        }
                        $data += $item | Select-Object Liked, Replied, Reposted, Quoted | Format-SpectreTable -Border Simple -Color $BorderColor -HeaderColor $TitleColor

                        "`n"
                        Write-SpectreRule -Title $item.date -Color $TitleColor -LineColor $BorderColor
                        $data | Format-SpectreRows
                    }
                }
                'FollowProfile' {
                    foreach ($item in $InputObject) {
                        $data = @()
                        $head = "$($item.Display) ([$TitleColor italic link=$($item.url)]$($item.Username)[/])"
                        if ($item.Avatar) {
                            $img = Get-SpectreImage -ImagePath $item.Avatar -MaxWidth 20
                        }
                        #break description into a 80 character line and break on spaces
                        $trim = $item.description -split '(.{1,80})(\s|$)' | Where-Object { $_ -ne "" } | ForEach-Object { $_.Trim() } | Where { $_ } | Out-String
                        $description = "`n[italic]$trim[/]"

                        $data += @($img, $description) | Format-SpectreColumns
                        If ($item.links.count -gt 0) {
                            $data += "`n[$BorderColor italic]Links:[/]"
                            $data += $item.links
                        }
                        $data += $item |  Select-Object -property Created, @{Name = "AccountAge"; Expression = { "{0:dd\.hh\:mm\:ss}" -f $_.Age } } |
                        Format-SpectreTable -Border Simple -Color $BorderColor -HeaderColor $TitleColor

                        $data | Format-SpectreRows | Format-SpectrePanel -Border Rounded -Color $BorderColor -Header $head -Expand
                    }
                }
                'PSBlueskyModuleInfo' {
                    $ModuleData += $InputObject
                }
                'PSBlueskyProfile' {
                    foreach ($item in $InputObject) {
                        $data = @()
                        if ($item.banner) {
                            $data += Get-SpectreImage -ImagePath $item.banner |
                            Format-SpectreAligned -HorizontalAlignment Center
                        }

                        $head = "$($item.Display) ([$TitleColor italic link=$($item.url)]$($item.Username)[/])"
                        $img = Get-SpectreImage -ImagePath $item.Avatar -MaxWidth 20
                        #break description into a 80 character line and break on spaces
                        $trim = $item.description -split '(.{1,80})(\s|$)' | Where-Object { $_ -ne "" } | ForEach-Object { $_.Trim() } | Where { $_ } | Out-String
                        $description = "`n[italic]$trim[/]"

                        $data += @($img, $description) | Format-SpectreColumns
                        If ($item.links.count -gt 0) {
                            $data += "`n[$BorderColor italic]Links:[/]"
                            $data += $item.links
                        }
                        $data += $item | Select-Object  Created, Posts, Followers, Following, Lists |
                        Format-SpectreTable -Border Simple -Color $BorderColor -HeaderColor $TitleColor |
                        Format-SpectreAligned -HorizontalAlignment Center

                        $data | Format-SpectreRows |
                        Format-SpectrePanel -Border Rounded -Color $BorderColor -Header $head -Expand
                    }
                }
                Default {
                    Write-SpectreHost "[italic magenta]$($strings.Unsupported -f $tName)[/]"
                    $process = $False
                }
            } #end switch
        } #if process
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        #ModuleInfo data gets processed at the end
        if ($ModuleData.Count -gt 0) {
            _verbose $strings.FinishedProcess
            $paramHash = @{
                Wrap        = $True
                Title       = "[underline link=https://github.com/jdhitsolutions/PSBluesky]PSBluesky[/] [[v$($ModuleData[0].version)]]"
                Color       = $BorderColor
                HeaderColor = $TitleColor
                AllowMarkup = $True
            }

            Get-SpectreImage $PSScriptRoot\..\images\butterfly.png -MaxWidth 25 | 
            Format-SpectreAligned -HorizontalAlignment Center

            $ModuleData | Select-Object -property @{Name = "Command"; Expression = {
            "[underline link=https://github.com/jdhitsolutions/PSBluesky/blob/main/docs/$($_.name).md]$($_.Name)[/]" }
            },
            @{Name = "Alias"; Expression = { "[italic $TitleColor]$($_.alias -join ',')[/]" } },
            Synopsis | Format-SpectreTable @paramHash | Format-SpectreAligned -HorizontalAlignment Center
        }
        _verbose $strings.Ending
    } #end
}

#define an argument completer
"BorderColor","TitleColor" | Foreach-Object {
    Register-ArgumentCompleter -CommandName Format-SpectreConsole -ParameterName $_ -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

        [Spectre.Console.Color] |
        Get-Member -Static -Type Properties |
        Where-Object name -like "$WordToComplete*"|
        Select-Object -ExpandProperty Name |
        ForEach-Object {
            $show = "[$_]$($_)[/]" | Out-SpectreHost
            [System.Management.Automation.CompletionResult]::new([Spectre.Console.Color]::$_, $show, 'ParameterValue', $_)
        }
    }
}

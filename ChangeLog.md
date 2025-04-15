# PSBluesky Changelog

## [Unreleased]
### Added
- Added a custom view to `PSBlueskyFollowers.format.ps1xml` to display avatar images is the pswSpectreConsole module is detected. This will apply to output from `Get-BskyFollowers` and `Get-BskyFollowing`.
- Added `Thumbnail` property to the'PSBlueskyFeedItem' and `'PSBlueskyTimelinePost'` objects.

### Changed
- Modified output from `Get-BskyFeed` and `Get-BskyTimeline` to include tags.
- Updated `Get-BskyFollower` and `Get-BskyFollowing` to include the account's avatar and labels.
- Updated profile formatting file to display the user's logo if the pwshSpectreConsole module is detected. This will apply to output from `Get-BskyProfile`, and `Find-BskyUser`.
- Added online help links

## [2.5.0] - 2025-01-29

### Added

- Added `PID` and `Host` to the API logging output.

### Changed

- Modified `Enable-BskyLogging` and `Set-BskyLogging` to populate a global variable `bskyLogFile` to make it easier to work with the file in the console
- Revised the regex pattern in `New-BskyPost` that was stripping out control characters to not remove new line characters.
- Updated `README`.
- Updated help documentation.

## [2.4.0] - 2025-01-22

### Added

- Added property `DID` to follower objects.
- Added a script method called `CreateHeader` to the Bluesky session object (`bskySession`). This header can be used with the Bluesky API for custom testing or development.
- Added commands `Block-BskyUser` and `Unblock-BskyUser`.
- Added properties `Viewer` and `Labels` to profile objects including blocked user profiles.
- Added a feature to create a log of API usage. Added properties `bskyLoggingEnabled` and `bskyLogFile` to the PSBluesky session object. The log is a JSON file of structured data. Logging is disabled by default on module import. Commands `Disable-BskyLogging`,`Enable-BskyLogging`,`Get-BskyLogging`,`Set-BskyLogging` and `Remove-BskyLogging` have been added to manage this feature.
- Added properties `isRead`, `Labels`, and `SeenAt` to`PSBlueSkyNotification` object. [[Issue #34](https://github.com/jdhitsolutions/PSBluesky/issues/34)]
- Added an alias property of `Username` for `AuthorHandle` on output from `Get-BskyNotification`.

### Changed

- Revised the module manifest description.
- Increased the refresh interval for the session runspace to 60 minutes. This should reduce the number of API calls. __This is a potential breaking change,__
- Cleaned up code to ensure consistency with commands. References to an endpoint should all use the same variable, `$apiUrl`. Responses from the API should all use the `$response` variable.
- Updated `Get-BskyBlockedUser` and the associated format file to show the date the account was blocked.
- Help updates.
- Updated `README.md`.

## [2.3.0] - 2025-01-13

### Added

- Added commands `New-BskyFollow` and `Remove-BskyFollow`, with aliases `Follow-BskyUser` and `Unfollow-BskyUser` to handle following and un-following Bluesky user accounts. [[Issue #32](https://github.com/jdhitsolutions/PSBluesky/issues/32)]
- Created a user-configurable preferences variable, `$bskyPreferences` and related commands: `Get-BskyPreference`, `Set-BskyPreference`, `Export-BskyPreference`, and `Remove-BskyPreferenceFile`. The preference variable is exported so that the formatting files can use it, but should be managed with the related functions. [[Issue #31](https://github.com/jdhitsolutions/PSBluesky/issues/31)]
- Added alias command `bsliked` for `Get-BskyLiked`.

### Changed

- Updated verbose helper function to use the new formatting preferences.
- Updated formatting files to use the new preference variable.
- Moved all type extensions defined in the module file using `Update-TypeData` to the external types.ps1xml file.
- Updated `README.md`.
- Updated help documentation.
- Updated module to remove additional types on module removal.

## [2.2.1] - 2025-01-10

### Fixed

- Added `Repost-BskyPost` alias to the module manifest.

## [2.2.0] - 2025-01-10

### Added

- Added command `Publish-BskyPost` with an alias of `Repost-BskyPost` which can be used to quote or repost. [[Issue #25](https://github.com/jdhitsolutions/PSBluesky/issues/25)]
- Added command `Get-BskyBlockedList` and associated format file. [[Issue #27](https://github.com/]jdhitsolutions/PSBluesky/issues/27)]
- Added command `Get-BskyBlockedUser` and associated format file.
- Added command `Get-BskyLiked` and associated format file.
- Added `-Today` parameter to `Get-BskyNotification` to only show notifications from the current day.
- Imported [PR #30](https://github.com/jdhitsolutions/PSBluesky/pull/30) from  [@jhoneill](https://github.com/jhoneill) to improve piping to `New-BskyPost`.
- Added properties `CID` to output from `Get-BskyLiked`,`Get-BskyNotification`,`Get-BskyTimeline`, and `Get-BskyFeed`. This is to support new commands for reposting and quoting.
- Added properties `URI` to output from `Get-BskyNotification`,`Get-BskyTimeline`, and `Get-BskyFeed`. This is to support new commands for reposting and quoting.
- Added a custom view called `Liked` to the `PSBlueskyTimelinePost.format.ps1xml`, `PSBlueskyLiked.format.ps1xml`, and `PSBlueskyFeed.format.ps1xml' files.


### Changed

- Changed output property `aturi` in `Get-BskyLiked` and `Get-BskyFeed` to `URI`. This is to support new commands for reposting and quoting. __This is a potential breaking change__
- Added support for gif files as an image upload type. The image will be static in the current release of Bluesky.
- Updated formatting files for `Get-BskyTimeline`, `Get-BskyLiked`, and `Get-BskyFeed` to highlight the number of likes.
- Help updates.
- Updated `README.md`.

### Removed

- Removed files previously marked as deprecated.

### Fixed

- Fixed a bug with loading localized help. [[Issue #29](https://github.com/jdhitsolutions/PSBluesky/issues/29)]
- Fixed image layout problems in the help PDF file.

## [2.1.0] - 2024-11-21

### Added

- Added alias `bss` for `Get-BskySession`.
- Added function `Get-BskyAccountDID`.
- Added parameter validation on image uploads to verify the image file size is less than 1MB.
- Merged [PR #23](https://github.com/jdhitsolutions/PSBluesky/pull/23) from [@jhoneill](https://github.com/jhoneill) to add label support for `New-BskyPost` and `-Username` to `Get-BskyFeed`.
- Added command `Get-BskyAccountDID`. This command does not require authentication.

### Changed

- Made `PostCache` a global-scoped variable and renamed it to `BskyPostCache``. Thanks to [@ShaunLawrie](https://github.com/ShaunLawrie) for the suggestion
- Revised parameter validations on `ImagePath` to provide more granular error messages.
- Updated `README` with documentation about setting up a credential using an app password.
- Revised `OnRemove` handler to remove type customizations. This should eliminate errors on module re-import in the same session.

### Removed

- Removed `gif` as a valid image type to upload.

### Fixed

- Modified `New-BskyPost` to re-order items that require facets so that the message is properly formatted. [[Issue #22](https://github.com/jdhitsolutions/PSBluesky/issues/22)]

## [2.0.0] - 2024-11-18

### Added

- Added script property called `Age` for types `PSBlueskyProfile`, `PSBlueskyFollowProfile`, and `PSBlueskySearchResult`.
- Added custom verbose messaging and localized string data.
- Added typename `PSBlueskyImageUpload` to `Add-BskyImage`.
- Added command `Get-BskyModuleInfo` and corresponding formatting file.
- Added a parameter to `Open-BskyHelp` to view the file as a markdown document.
- Added support for proper notifications and tags in new messages. [[Issue #19](https://github.com/jdhitsolutions/PSBluesky/issues/19)]
- Added command aliases:
    - bsfeed --> `Get-BskyFeed`
    - bsfollow --> `Get-BskyFollowing`
    - bsfollower --> `Get-BskyFollowers`
    - bshelp --> `Open-BskyHelp`
    - bsn --> `Get-BskyNotification`
    - bsp --> `Get-BskyProfile`
    - bst --> `Get-BskyTimeline`
    - bsu --> `Find-BskyUser`
    - Refresh-BskySession --> `Update-BskySession`
    - skeet --> `New-BskyPost`

### Changed

- Modified commands to __not__ require a credential except for `Start-BskySession`. Commands will get the access token from the session object. __This is a breaking change__ [[Issue #20](https://github.com/jdhitsolutions/PSBluesky/issues/20)]

### Removed

- Removed `Get-BskyAccessToken` and replaced it with `Start-BskySession`. __This is a breaking change__

## [1.3.0] - 2024-11-15

### Added

- Added command `Find-BSkyUser` and corresponding format file.
- Added code to get the text of referenced posts and cache them in a hashtable. The caching hashtable is referenced by a module-scoped variable.

### Changed

- Modified commands to use a user's DID instead of the username or handle. Some API endpoints don't work well with handles. __This is a possible breaking change__ [[Issue #18](https://github.com/jdhitsolutions/PSBluesky/issues/18)]
- Minor code cleanup and refactoring. Increased the use of splatting to improve code readability.
- Updated the profile object to include the account DID.
- Modified formatting and the default object for Bluesky notifications to include the text of a reference post that is either liked or reposted. __This is a breaking change.__
- Updated `Get-BskyNotification` to allow filtering by notification type.
- Updated formatting file for notifications to support additional notification types.
- Updated help documentation.
- Updated `README.md`

### Fixed

- Added support for `repost` and `reply` notifications in the `PSBlueskyNotification.format.ps1xml` file. [[Issue #17](https://github.com/jdhitsolutions/PSBluesky/issues/17)]
- Fixed notification hyperlinks in `PSBlueskyNotification.format.ps1xml`.

## [1.2.0] - 2024-11-13

### Added

- Added the alias `Alt` for `ImageAlt` in `New-BskyPost`.
- Added alias `Refresh-BskySession` for `Update-BskySession`
- Accepted [PR #12](https://github.com/jdhitsolutions/PSBluesky/pull/12) to fix casing issues which were causing problems loading the module on Linux. Thanks [@Skatterbrainz](https://github.com/Skatterbrainz)!
- Added additional verbose messaging to commands to show what platform is being used and the module version.
- Added command `Get-BskyNotification` and corresponding format file.

### Changed

- Updated `Get-BskyFollowers` to use paging to get all followers. [PR #11](https://github.com/jdhitsolutions/PSBluesky/pull/12) Thanks to [@Skatterbrainz](https://github.com/Skatterbrainz) for solving an issue on my to do list.
- Updated `New-BskyPost` to properly handle mentions and format as inline links. [[Issue #14](https://github.com/jdhitsolutions/PSBluesky/issues/14)]
- Update `Get-BskyFollowing` to allow the user to get all accounts. [[Issue #16](https://github.com/jdhitsolutions/PSBluesky/issues/16)]
- Major update to the way the module handles the session object and tokens. The module uses a background runspace to update the session object every 15 minutes. This should keep your Bluesky access tokens good for as long as the module is loaded without having to worrying about refreshing the module. __This is a breaking change__.
- Updated `README.md` to reflect changes and new features.

## [1.1.0] - 2024-11-07

### Added

- Moved the helper function `_RefreshSession` to a public function, `Update-BskySession`.

### Changed

- Modified `New-BSkyPost` to accept pipeline input.
- Updated default formatting for Bluesky timeline items to use a custom format. The Table definition remains as a named view.
- Modified session code to refresh the session if the age is greater than 60 minutes.
- Updated `README.md`.
- Revised the PDF help document formatting.
- Help documentation updates.

## [1.0.0] - 2024-11-02

### Changed

- Renamed help PDF file to `PSBlueSky-Help.pdf`. This is probably a break change but since the expectation is to run `Open-BskyHelp` (which has been updated with the new file name) to open the file, it shouldn't be an issue.
- Updated `New-BskyPost` to support Markdown style links. [[Issue #6](https://github.com/jdhitsolutions/PSBluesky/issues/6)]
- Updated `README.md`.
- Updated module manifest to version `1.0.0`. This should be a very stable version with almost all of the intended functionality.

## [0.6.0] - 2024-11-01

This is the first version published to the PowerShell Gallery.

### Added

- Added command `Open-BskyHelp` to open a PDF version of the module's `README.md` file.
- Added custom format file for `PSBlueskySession` objects.
- Added alias properties `AccessToken` and `RefreshToken` for the `PSBlueskySession` object.

### Changed

- Updated help documentation

## [0.5.0] - 2024-10-31

### Added

- Added command `Get-BskySession`.
- Added a ScriptProperty called `Age` for the profile type objects.
- Added an Alias property of `Name` for `UserName` in the profile type objects.
- Added a property set called `Stats` for timeline and feed objects.

### Changed

- Updated the module to re-use and refresh Bluesky sessions. This should help with API rate limits since the commands aren't creating a new session for each request. [[Issue #7](https://github.com/jdhitsolutions/PSBluesky/issues/7)] __This is a breaking change__.
- Modified `Get-BskyProfile` to default the username to the specified credential. [[Issue #8](https://github.com/jdhitsolutions/PSBluesky/issues/8)]
- Renamed module commands. Example `Get-PSBlueskyProfile` is now `Get-BskyProfile`. __This is a breaking change__
- Documentation updates and corrections.
- Modified commands that write Profile type objects to use the accounts username for the DisplayName, if the `DisplayName` is not defined.
- Updated Pester tests.

## [0.4.0] - 2024-10-27

### Added

- Added command help documentation. [[Issue #4](https://github.com/jdhitsolutions/PSBluesky/issues/4)]
- Added command `Get-BskyFollowers` and associated format file
- Added command `Get-BskyFollowing` which uses the same format file as `Get-BskyFollowers`.
- Added command `Get-BskyFeed` and associated custom format file.

### Changed

- Updated `README.md`.
- Modified `Get-BskyProfile` to accept user name as pipeline input.

### Fixed

- Hopefully fixed linking in new posts. [Issue #3](https://github.com/jdhitsolutions/PSBluesky/issues/3)

## [0.3.0] - 2024-10-26

### Added

- Added custom format file for profiles.
- Added command `Get-BskyTimeline` and corresponding format file.

### Changed

- Updated the Bluesky profile object to include a URL to the profile.
- Updated the ability to post links.
- Updated `README.md`.

## 0.2.0 - 2024-10-25

### Changed

- Changed casing references from `BlueSky` to `bluesky`.
- Updated `README.md`.
- Changed the global `PDSHOST`variable to a module-scoped variable.

## 0.1.0 - 2024-10-25

### Added

- initial files and module structure

[Unreleased]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.5.0..HEAD
[2.5.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.4.0..v2.5.0
[2.4.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.3.0..v2.4.0
[2.3.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.2.1..v2.3.0
[2.2.1]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.2.0..v2.2.1
[2.2.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.1.0..v2.2.0
[2.1.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v2.0.0..v2.1.0
[2.0.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v1.3.0..v2.0.0
[1.3.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v1.1.0..v1.2.0
[1.1.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v1.0.0..v1.1.0
[1.0.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.6.0..v1.0.0
[0.6.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.5.0..v0.6.0
[0.5.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.4.0..v0.5.0
[0.4.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.3.0..v0.4.0
[0.3.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.2.0...v0.3.0
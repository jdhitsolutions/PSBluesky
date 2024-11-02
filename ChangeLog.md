# PSBluesky Changelog

This changelog is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

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

[Unreleased]: https://github.com/jdhitsolutions/PSBluesky/compare/v1.0.0..HEAD
[1.0.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.6.0..v1.0.0
[0.6.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.5.0..v0.6.0
[0.5.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.4.0..v0.5.0
[0.4.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.3.0..v0.4.0
[0.3.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.2.0...v0.3.0
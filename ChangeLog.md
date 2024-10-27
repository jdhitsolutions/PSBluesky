# Changelog

This changelog is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.4.0] - 2024-10-27

### Added

- Added command help documentation. [Issue #4](https://github.com/jdhitsolutions/PSBluesky/issues/4)
- Added command `Get-PSBlueskyFollowers` and associated format file
- Added command `Get-PSBlueskyFollowing` which uses the same format file as `Get-PSBlueskyFollowers`.
- Added command `Get-PSBlueskyFeed` and associated custom format file.

### Changed

- Updated `README.md`.
- Modified `Get-PSBlueskyProfile` to accept user name as pipeline input.

### Fixed

- Hopefully fixed linking in new posts. [Issue #3](https://github.com/jdhitsolutions/PSBluesky/issues/3)

## [0.3.0] - 2024-10-26

### Added

- Added custom format file for profiles.
- Added command `Get-PSBlueskyTimeline` and corresponding format file.

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

[Unreleased]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.4.0..HEAD
[0.4.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.3.0..v0.4.0
[0.3.0]: https://github.com/jdhitsolutions/PSBluesky/compare/v0.2.0...v0.3.0
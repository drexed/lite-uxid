# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.2] - 2024-09-23
### Changed
- Improve configuration template
- Improve hashid generation
### Removed
- Hashid size option

## [2.0.1] - 2024-09-23
### Changed
- Renamed `Scatterid` to `Obfuscateid`
### Removed
- Removed prefix option from obfuscateid

## [2.0.0] - 2024-09-23
### Added
- Scatterid reversible lib
### Changed
- Reorganize generators into better namespaces
- Fixed issue where nanoid would return without the prefix
- Moved charsets to constants

## [1.5.2] - 2024-09-20
### Changed
- Fixed nanoid of differing length error

## [1.5.1] - 2024-09-20
### Changed
- Use after commit on create instead of after create

## [1.5.0] - 2024-09-20
### Added
- Added uuid version option
- Added prefix option to hashid and nanoid
### Changed
- Move reversible and irreversible files to base namespace
- Ruby send perf improvements

## [1.4.0] - 2022-11-20
### Changed
- Improved global config flexibility
- Update config generator to generate dynamic salt

## [1.3.0] - 2022-11-20
### Added
- Added uuid option

## [1.2.0] - 2022-11-19
### Added
- Added individual character and size options
### Changed
- Improved docs
- Improved internal setup
- Improved rubocop setup

## [1.1.3] - 2021-07-30
### Changed
- Skip uxid callback on records where its being assigned

## [1.1.2] - 2021-07-22
### Changed
- Improved setup

## [1.1.1] - 2021-07-21
### Changed
- Improved Railtie support

## [1.1.0] - 2021-07-19
### Added
- Added Ruby 3.0 support

## [1.0.8] - 2021-05-07
### Changed
- Linter fixes

## [1.0.7] - 2019-08-26
### Added
- Added ruby 2.7 support
- Added prevention of Nanoid collision when using with active_record
### Changed
- Renamed Hash to Hashid

## [1.0.6] - 2019-08-26
### Changed
- Improved how configuration works
### Removed
- Remove active_record requirement that are already provided by Rails

## [1.0.5] - 2019-08-24
### Changed
- Improved how configuration works

## [1.0.4] - 2019-08-15
### Changed
- Underscore initializer file name

## [1.0.3] - 2019-07-31
### Added
- Added benchmarks
### Changed
- Changed instance method names to match class names
- Changed Nanoid encoder to be faster
- Changed Ulid encoder to be faster

## [1.0.2] - 2019-07-30
### Added
- Added Nanoid

## [1.0.1] - 2019-06-25
### Removed
- Remove unused active_support dependency

## [1.0.0] - 2019-06-25
### Added
- Initial project version

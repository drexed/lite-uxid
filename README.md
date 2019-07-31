# Lite::Uxid

[![Gem Version](https://badge.fury.io/rb/lite-uxid.svg)](http://badge.fury.io/rb/lite-uxid)
[![Build Status](https://travis-ci.org/drexed/lite-uxid.svg?branch=master)](https://travis-ci.org/drexed/lite-uxid)

Lite::Uxid is a library for generating or obfuscating Id's based on Hash and ULID algorithms.
It's very useful to hide the number of resources in your database and protect against enumeration attacks.

**NOTE:** If you are coming from `ActiveUxid`, please read the [port](#port) section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lite-uxid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite-uxid

## Table of Contents

* [Configuration](#configuration)
* [Hash](#hash)
* [NanoID](#nanoid)
* [ULID](#ulid)
* [ActiveRecord](#active_record)
* [Benchmarks](#benchmarks)
* [Port](#port)

## Configuration

`rails g lite:uxid:install` will generate the following file:
`../config/initalizers/lite-uxid.rb`

```ruby
Lite::Uxid.configure do |config|
  config.encoding_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  config.encoding_length = 26
  config.encoding_salt = 1_369_136
end
```

## Hash

Hash ID's are reversible and is the most performant generator.

```ruby
Lite::Uxid::Hash.encode(10)         #=> 'q5D8inm0'
Lite::Uxid::Hash.decode('q5D8inm0') #=> 10
```

## NanoID

NanoID are not reversible and are the second fastest ID generator but while unlikely can produce collisions.

```ruby
Lite::Uxid::Nanoid.encode #=> '0bmHjB5Gx8FTBqJekX6dS6XIXf'
```

## ULID

ULID are not reversible but provide information outside of just randomness.

```ruby
Lite::Uxid::Ulid.encode #=> '1mqfg9qa96s8s5f02o1ucf8lcc'
```

#### ActiveRecord

**Table**

Add the following attribute to all corresponding tables.

```ruby
# omitted
  t.binary :uxid, limit: 26, index: { unique: true }
# omitted
```

**Setup**

All `nanoid` and `uxid` attributes will be automatically generated and applied when the record is created.

```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Hash

  # - or -

  include Lite::Uxid::Record::Nanoid

  # - or -

  include Lite::Uxid::Record::Ulid
end
```

**Usage**

The following methods are for Hash based Uxid's.

```ruby
User.find_by_ulid('x123')   #=> Find record by uxid
User.find_by_ulid!('x123')  #=> Raises an ActiveRecord::RecordNotFound error if not found

user = User.new
user.hash_to_id             #=> Decodes the records uxid to id (only for Hash based Id's)
```

## Benchmarks

The classes ranked from fastest to slowest are `Hash`, `Nanoid`, and `Ulid`.

View how each compares by running the [benchmarks](https://github.com/drexed/lite-uxid/tree/master/benchmarks).

## Port

`Lite::Uxid` is a compatible port of [ActiveUxid](https://github.com/drexed/active_uxid).

Switching is as easy as renaming `ActiveUxid` to `Lite::Uxid`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lite-uxid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Uxid project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lite-uxid/blob/master/CODE_OF_CONDUCT.md).

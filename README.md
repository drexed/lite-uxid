# Lite::Uxid

[![Gem Version](https://badge.fury.io/rb/lite-uxid.svg)](http://badge.fury.io/rb/lite-uxid)
[![Build Status](https://travis-ci.org/drexed/lite-uxid.svg?branch=master)](https://travis-ci.org/drexed/lite-uxid)

Lite::Uxid is a library for generating or obfuscating ID's based on different patterns.
It's very useful to hide the number of resources in your database and protect against enumeration attacks.
By default, it implements websafe variants of each type.

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
* [Usage](#usage)
* [Hashid](#hashid)
* [NanoID](#nanoid)
* [ULID](#ulid)
* [UUID](#uuid)
* [Options](#options)
* [ActiveRecord](#active_record)
* [Benchmarks](#benchmarks)

## Configuration

`rails g lite:uxid:install` will generate the following file in your application root:
`config/initalizers/lite_uxid.rb`

```ruby
Lite::Uxid.configure do |config|
  config.hashid_charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.hashid_salt = 1_369_136
  config.hashid_size = 16
  config.nanoid_charset = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.nanoid_size = 21
  config.ulid_charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  config.ulid_size = 26
end
```

## Usage

#### Instance
```ruby
coder = Lite::Uxid::Hashid.new(10, size: 12)
coder.encode #=> '67wGI0'
```

#### Class
```ruby
Lite::Uxid::Hashid.decode('67wGI0', size: 12) #=> 10
```

## Hashid

[More information](https://hashids.org)

```ruby
Lite::Uxid::Hashid.encode(10)        #=> '1zWr1m0'
Lite::Uxid::Hashid.decode('1zWr1m0') #=> 10
```

## NanoID

[More information](https://github.com/ai/nanoid)

```ruby
Lite::Uxid::Nanoid.encode #=> 'sMuNUa3Cegn6r5GRQ4Ij2'
```

## ULID

[More information](https://github.com/ulid/spec)

```ruby
Lite::Uxid::Ulid.encode #=> '01GJAY9KGR539EZF4QWYEJGSN7'
```

## UUID

Implements v4 of the specification. [More information](https://en.wikipedia.org/wiki/Universally_unique_identifier)

```ruby
Lite::Uxid::Uuid.encode #=> '4376a67e-1189-44b3-a599-7f7566bf105b'
```

## Options

Local options can be passed to override global options.

```ruby
Lite::Uxid::Ulid.encode(chars: 'abc123', size: 12) #=> 'a3b12c12c3ca'
```

## ActiveRecord

**Table**

Add the following attribute to all corresponding tables.

```ruby
t.string :uxid, index: { unique: true }
```

**Setup**

`uxid` attribute will be automatically generated and applied when the record is created.

#### HashID
```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Hashid
end
```

#### NanoID
```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Nanoid
end
```

#### ULID
```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Ulid
end
```

#### UUID
```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Uuid
end
```

**Usage**

Using one of the mixins above provides a handy method to find records by uxid.

#### HashID methods
```ruby
user = User.new
user.id_to_uxid #=> Encodes the records id to uxid
user.uxid_to_id #=> Decodes the records uxid to id
```

#### Finder methods
```ruby
User.find_by_uxid('x123')  #=> Find record by uxid
User.find_by_uxid!('x123') #=> Raises an ActiveRecord::RecordNotFound error if not found
```

## Benchmarks

The classes ranked from fastest to slowest are `UUID`, `Hashid`, `Nanoid`, and `Ulid`.

View how each compares by running the [benchmarks](https://github.com/drexed/lite-uxid/tree/master/benchmarks).

#### Alternatives

Learn more about alternative functions and more advance hashing setups:
[hashids.org](https://hashids.org)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drexed/lite-uxid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Uxid project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/drexed/lite-uxid/blob/master/CODE_OF_CONDUCT.md).

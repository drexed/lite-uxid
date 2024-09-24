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
* [Options](#options)
* [Reversible](#reversible)
    * [HashID](#hashid)
    * [ObfuscateID](#obfuscateid)
* [Irreversible](#Irreversible)
    * [NanoID](#nanoid)
    * [ULID](#ulid)
    * [UUID](#uuid)
* [ActiveRecord](#active_record)
* [Benchmarks](#benchmarks)

## Configuration

`rails g lite:uxid:install` will generate the following file in your application root:
`config/initalizers/lite_uxid.rb`

```ruby
Lite::Uxid.configure do |config|
  # HashID
  config.hashid_charset = Lite::Uxid::ALPHANUMERIC
  config.hashid_salt = 1_369_136

  # NanoID
  config.nanoid_charset = Lite::Uxid::WEB_SAFE
  config.nanoid_size = 21

  # ObfuscatedID
  config.obfuscateid_spin = 0

  # ULID
  config.ulid_charset = Lite::Uxid::COCKFORDS_32
  config.ulid_size = 26

  # UUID
  config.uuid_version = 4
end
```

## Usage

### Instance call

```ruby
coder = Lite::Uxid::Reversible::Hashid.new(10, size: 12)
coder.encode #=> '67wGI0'
```

### Class call
```ruby
Lite::Uxid::Reversible::Hashid.decode('67wGI0', size: 12) #=> 10
```

## Options

Local options can be passed to override global options.

```ruby
Lite::Uxid::Irreversible::Ulid.encode(charset: 'abc123', size: 12) #=> 'a3b12c12c3ca'
```

Passable options are:

```ruby
{
  charset: 'string',  # Available for: hashid, nanoid, ulid
  salt:    'string',  # Available for: hashid
  size:    'integer', # Available for: nanoid, ulid
  spin:    'integer', # Available for: obfuscateid
  version: 'integer', # Available for: uuid
  prefix:  'string'   # Available for: hashid, nanoid, ulid, uuid
}
```

## Reversible

### HashID

- [More information](https://hashids.org)

```ruby
Lite::Uxid::Reversible::Hashid.encode(10)             #=> '7pau2oXSklq0'
Lite::Uxid::Reversible::Hashid.decode('7pau2oXSklq0') #=> 10
```

### NanoID

- [More information](https://github.com/ai/nanoid)

```ruby
Lite::Uxid::Irreversible::Nanoid.encode #=> 'sMuNUa3Cegn6r5GRQ4Ij2'
```

## Irreversible

### ObfuscateID

- [More information](https://github.com/namick/scatter_swap)

```ruby
Lite::Uxid::Reversible::Obfuscateid.encode(10)         #=> 2056964183
Lite::Uxid::Reversible::Obfuscateid.decode(2056964183) #=> 10
```

### ULID

- [More information](https://github.com/ulid/spec)

```ruby
Lite::Uxid::Irreversible::Ulid.encode #=> '01GJAY9KGR539EZF4QWYEJGSN7'
```

### UUID

Implements `v4` and `v7` of the specification.
- [More information](https://en.wikipedia.org/wiki/Universally_unique_identifier)

```ruby
Lite::Uxid::Irreversible::Uuid.encode #=> '4376a67e-1189-44b3-a599-7f7566bf105b'
```

## ActiveRecord

### Table

Add the following attribute to all corresponding tables.

```ruby
# NOTE: null: true has to be set for HashID's
# since an ID must exist before it gets created.
t.string :uxid, null: false, index: { unique: true }
```

If using UUID or ULID and your database supports it:

```ruby
t.uuid :uxid, null: false, index: { unique: true }
```

**Setup**

`uxid` attribute will be automatically generated and applied when the record is created.

### Mixin
```ruby
class User < ActiveRecord::Base
  # Pick one:
  include Lite::Uxid::Record::Hashid
  include Lite::Uxid::Record::Nanoid
  include Lite::Uxid::Record::Obfuscateid
  include Lite::Uxid::Record::Ulid
  include Lite::Uxid::Record::Uuid
end
```

HashID, NanoID, ULID, and UUID modules allow prefixing via the `uxid_prefix` method.

```ruby
class User < ActiveRecord::Base
  include Lite::Uxid::Record::Hashid

  def uxid_prefix
    "usr_"
  end
end
```

Using the `hashid` and `nanoid` above provide handy methods to find records by uxid.

```ruby
user = User.new
user.id_to_uxid #=> Encodes the records id to uxid
user.uxid_to_id #=> Decodes the records uxid to id

User.find_by_uxid('x123')  #=> Find record by uxid
User.find_by_uxid!('x123') #=> Raises an ActiveRecord::RecordNotFound error if not found
```

## Benchmarks

The classes ranked from fastest to slowest are `UUID`, `HashID`, `NanoID`, `ULID`, and `ObfuscateID`. Here are the latest results:

```
Calculating -------------------------------------
              Hashid    135.993k (± 2.9%) i/s    (7.35 μs/i) -    681.588k in   5.016413s
         Obfuscateid     30.702k (± 2.2%) i/s   (32.57 μs/i) -    155.907k in   5.080592s
              NanoID     99.327k (± 1.5%) i/s   (10.07 μs/i) -    504.135k in   5.076630s
                ULID     82.211k (± 2.3%) i/s   (12.16 μs/i) -    418.455k in   5.092823s
             UUID v4    237.629k (± 6.8%) i/s    (4.21 μs/i) -      1.190M in   5.040477s
             UUID v7    234.956k (±13.8%) i/s    (4.26 μs/i) -      1.153M in   5.051057s

Comparison:
             UUID v4:   237629.0 i/s
             UUID v7:   234955.9 i/s - same-ish: difference falls within error
              Hashid:   135993.5 i/s - 1.75x  slower
              NanoID:    99327.3 i/s - 2.39x  slower
                ULID:    82210.7 i/s - 2.89x  slower
         Obfuscateid:    30702.0 i/s - 7.74x  slower
```

View how each compares by running the [benchmarks](https://github.com/drexed/lite-uxid/tree/master/benchmarks).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drexed/lite-uxid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Uxid project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/drexed/lite-uxid/blob/master/CODE_OF_CONDUCT.md).

# ActsAsEncryptable
[![Gem Version](https://badge.fury.io/rb/acts_as_encryptable.svg)](https://badge.fury.io/rb/acts_as_encryptable)
[![Build Status](https://travis-ci.org/danielpclark/acts-as-messageable.svg?branch=master)](https://travis-ci.org/danielpclark/acts-as-messageable)

This gem adds support with ActiveSupport's existing message encryption
and allows you to set any ActiveRecord model column as an encrypted field.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_encryptable'
```

And create an initializer file:

```ruby
# config/initializers/acts_as_encryptable.rb
ActiveRecord::Base.extend ActsAsEncryptable
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_encryptable

## Usage

Adding encryption to any column is as easy as writing a few lines.

```ruby
class Email < ActiveRecord::Base
  acts_as_encryptable :raw_body, :the_key, :the_salt

  private
  def the_key
    "example key" # Some consistent/secure way to derive the key
  end

  def the_salt
    "example salt" # Some consistent/secure way to derive the salt
  end
end
```

If you're encrypting multiple fields you may choose to vary what keys and salts
are used per column, but this will add a performance hit for the extra
encryption startup time.

If you want to perform additional work on record data that you want to encrypt;
write a method alias after the `acts_as_encryptable` decleration and have your
new method call it.  `acts_as_encryptable` should always be written before any
method aliasing.

```ruby
# Example
alias_method :renamed_method, :current_example

def current_example
  renamed_method.do_something
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danielpclark/acts_as_encryptable.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


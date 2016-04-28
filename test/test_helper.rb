$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'acts_as_encryptable'

gem 'activerecord'
require 'active_record'
require 'active_support'
require 'minitest/autorun'
require 'color_pound_spec_reporter'
require 'logger'

Minitest::Reporters.use! [ColorPoundSpecReporter.new]

## This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :my_emails, force: true  do |t|
    t.text     "to"
    t.text     "from"
    t.text     "subject"
    t.text     "raw_body"
  end
end

ActiveRecord::Base.extend ActsAsEncryptable

class MyEmail < ActiveRecord::Base
  acts_as_encryptable :raw_body, :the_key, :the_salt

  private
  def the_key
    [to[0..5], from[-8..-1], subject[0..13]].compact.join
  end

  def the_salt
    [subject[0..-5], to.reverse, from.upcase].compact.join.unpack("m*").first
  end
end

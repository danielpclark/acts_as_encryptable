# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_encryptable/version'

Gem::Specification.new do |spec|
  spec.name          = "acts_as_encryptable"
  spec.version       = ActsAsEncryptable::VERSION
  spec.authors       = ["Daniel P. Clark"]
  spec.email         = ["6ftdan@gmail.com"]

  spec.summary       = %q{Adds simple record encryption for Rails.}
  spec.description   = %q{Extends Rails existing encryption methods and adds simple record encryption.}
  spec.homepage      = "https://github.com/danielpclark/acts_as_encryptable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '>= 4.1'

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'activerecord', '~> 4.1'
  spec.add_development_dependency 'activesupport', '~> 4.1'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "minitest", "~> 5.8.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency "color_pound_spec_reporter", "~> 0.0.5"
end

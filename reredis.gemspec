# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'reredis/version'
require "reredis/constant"

Gem::Specification.new do |spec|
  spec.name          = "reredis"
  spec.version       = Reredis::VERSION
  spec.authors       = ["Phan Trung Kien"]
  spec.email         = ["kienpt@lifetimetech.vn"]
  spec.description   = %q{A custorm gem redis}
  spec.summary       = %q{A custorm gem redis}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_rubygems_version = ">= 1.3.6"

  # = Library dependencies
  #
  spec.add_dependency "rake"
  spec.add_dependency "multi_json",  "~> 1.3"
  spec.add_dependency "activemodel", ">= 3.0"
  spec.add_dependency "activesupport"
  # = Library dependencies
  #
  spec.add_development_dependency "rails"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "redis"
  spec.add_development_dependency "activerecord"
end

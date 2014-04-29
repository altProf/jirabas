# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jirabas/version'

Gem::Specification.new do |spec|
  spec.name          = "jirabas"
  spec.version       = Jirabas::VERSION
  spec.authors       = ['Proffard', "Leo"]
  spec.email         = ["leonid.inbox@gmail.com"]
  spec.summary       = %q{This helps you know what you're working on right now}
  spec.description   = %q{This helps you know what you're working on right now}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'jira-ruby', '0.1.8'
  spec.add_dependency 'highline', '1.6.21'
  #spec.add_dependency 'trollop'
  spec.add_dependency 'activesupport', '4.0.4'
  spec.add_dependency 'retryable', '1.3.5'

  #just to shut up WARN Unresolved spec during .. reset
  spec.add_dependency 'multi_json', '1.9.2'
  spec.add_dependency 'tzinfo', '0.3.37'
  spec.add_dependency 'thread_safe', '0.3.3'

  spec.add_development_dependency 'bundler', "~> 1.5"
  spec.add_development_dependency 'rake'
end

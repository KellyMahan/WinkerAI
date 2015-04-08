# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'winker_ai/version'

Gem::Specification.new do |spec|
  spec.name          = "WinkerAI"
  spec.version       = WinkerAI::VERSION
  spec.authors       = ["Kelly Mahan"]
  spec.email         = ["kmahan@kmahan.com"]
  spec.summary       = %q{WinkerAI is an AI approach to controlling Wink hub components by making use of the Winker gem and Wink API}
  spec.description   = %q{WinkerAI is an AI approach to controlling Wink hub components by making use of the Winker gem and Wink API}
  spec.homepage      = "https://github.com/KellyMahan/WinkerAI"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'winker'
end

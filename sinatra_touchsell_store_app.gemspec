# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra_touchsell_store_app/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra_touchsell_store_app"
  spec.version       = SinatraTouchsellStoreApp::VERSION
  spec.authors       = ["Gauthier Monserand"]
  spec.email         = ["dev@touch-sell.com"]

  spec.summary       = %q{Quickly generate Touch & Sell store app}
  spec.description   = %q{Helpers for Sinatra to generate Touch & Sell store application}
  spec.homepage      = "http://rubygems.org/gems/sinatra_touchsell_store_app"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'sinatra', '~> 2.0'
  spec.add_runtime_dependency 'sinatra-flash', '~> 0.3.0'
  spec.add_runtime_dependency 'thin'
  spec.add_runtime_dependency 'haml'
  spec.add_runtime_dependency 'tilt'
  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'oauth2', '~> 1.3.1'

end

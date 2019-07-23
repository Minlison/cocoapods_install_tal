# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-install_tal/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-install_tal'
  spec.version       = CocoapodsInstall_tal::VERSION
  spec.authors       = ['MinLison']
  spec.email         = ['yuanhang.1991@icloud.com']
  spec.description   = %q{A short description of cocoapods-install_tal.}
  spec.summary       = %q{A longer description of cocoapods-install_tal.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-install_tal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  
  spec.add_dependency "cocoapods", '>= 1.5.3', '< 2.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end

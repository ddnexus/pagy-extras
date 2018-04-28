
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'

Gem::Specification.new do |s|
  s.name          = 'pagy-extras'
  s.version       = '0.1.1'
  s.authors       = ['Domizio Demichelis']
  s.email         = ['dd.nexus@gmail.com']
  s.date          = Date.today.to_s

  s.summary       = 'Pagy extra features'
  s.description   = 'Pagy extra features: bootstrap, responsive, compact, ...'
  s.homepage      = 'https://github.com/ddnexus/pagy-extras'
  s.license       = 'MIT'
  s.require_paths = ['lib']

  s.files         = `git ls-files -z`.split("\x0").select{|f| f.start_with?('lib', 'pagy-extras.gemspec', 'LICENSE') }


  s.add_dependency 'pagy', '~> 0.6.0'

  s.add_development_dependency 'bundler',  '~> 1.16'
  s.add_development_dependency 'rake',     '~> 10.0'
end

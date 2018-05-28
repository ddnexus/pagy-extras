
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'

Gem::Specification.new do |s|
  s.name          = 'pagy-extras'
  s.version       = '0.3.0'
  s.authors       = ['Domizio Demichelis']
  s.email         = ['dd.nexus@gmail.com']
  s.date          = Date.today.to_s

  s.summary       = 'Discontinued gem, now integrated in Pagy'
  s.description   = 'Discontinued gem, now integrated in Pagy. Use Pagy directly.'
  s.homepage      = 'https://github.com/ddnexus/pagy-extras'
  s.license       = 'MIT'
  s.require_paths = ['lib']

  s.files         = `git ls-files -z`.split("\x0").select{|f| f.start_with?('lib', 'pagy-extras.gemspec', 'LICENSE') }

  s.add_dependency 'pagy', '>= 0.8.0'

  s.add_development_dependency 'bundler',  '~> 1.16'
  s.add_development_dependency 'rake',     '~> 10.0'

  s.post_install_message      = <<EOM
******************************************************************************
      The pagy-extras gem has been integrated in pagy and discontinued 
     Read how to change your code https://github.com/ddnexus/pagy-extras 
******************************************************************************
EOM

end

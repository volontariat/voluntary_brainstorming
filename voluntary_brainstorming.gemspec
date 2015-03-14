$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'voluntary_brainstorming/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'voluntary_brainstorming'
  s.version     = VoluntaryBrainstorming::VERSION
  s.authors     = ['Mathias Gawlista']
  s.email       = ['gawlista@gmail.com']
  s.homepage    = 'http://Volontari.at'
  s.summary     = 'Draft: plugin for crowdsourcing management system voluntary about brainstorming of ideas and their pros / cons with voting.'
  s.description = 'Draft: plugin for crowdsourcing management system voluntary about brainstorming of ideas and their pros / cons with voting.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'voluntary', '~> 0.2.2'

  s.add_development_dependency 'mysql2'
end

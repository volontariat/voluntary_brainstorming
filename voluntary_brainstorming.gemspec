$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'voluntary_brainstorming/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'voluntary_brainstorming'
  s.version     = VoluntaryBrainstorming::VERSION
  s.authors     = ['Mathias Gawlista']
  s.email       = ['gawlista@gmail.com']
  s.homepage    = 'http://Volontari.at/products/brainstorming'
  s.summary     = 'Brainstorming plugin for crowdsourcing management system Voluntary.Software.'
  s.description = 'Brainstorming plugin for #crowdsourcing gem voluntary: http://bit.ly/vb-0-0-2'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'voluntary', '~> 0.5'
  s.add_dependency 'voluntary-ember_js', '~> 0.1.0'
  
  s.add_dependency 'message_bus', '~> 1.0.16'

  # group :development
  
  s.add_development_dependency 'letter_opener', '~> 1.0.0'

  # for tracing AR object instantiation and memory usage per request
  s.add_development_dependency 'oink', '~> 0.10.1'

  # group :development, :test
  s.add_development_dependency 'awesome_print', '~> 1.1.0'
  s.add_development_dependency 'rspec-rails', '~> 2.0' 
  
  # group :test
  s.add_development_dependency 'capybara', '~> 2.4.4'
  s.add_development_dependency 'capybara-webkit', '~> 1.6.0'
  s.add_development_dependency 'cucumber-rails-training-wheels', '~> 1.0.0'
  s.add_development_dependency 'timecop', '~> 0.6.1'
  s.add_development_dependency 'factory_girl_rails', '~> 1.7.0'
  s.add_development_dependency 'fixture_builder', '~> 0.3.3'
  s.add_development_dependency 'selenium-webdriver', '~> 2.22.1'
  s.add_development_dependency 'spork', '~> 1.0rc2'
  s.add_development_dependency 'guard-rspec', '~> 3.0.2'
  s.add_development_dependency 'guard-spork', '~> 1.5.1'
  s.add_development_dependency 'guard-cucumber', '~> 1.4.0'
  s.add_development_dependency 'launchy', '~> 2.1.2'

  # group :cucumber, :test
  s.add_development_dependency 'database_cleaner', '~> 0.7.1'
  s.add_development_dependency 'test-unit', '~> 3.0.9'
end

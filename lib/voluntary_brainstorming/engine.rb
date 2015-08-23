module VoluntaryBrainstorming
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../..", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/models/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/serializers", __FILE__)
    config.i18n.load_path += Dir[File.expand_path("../../../config/locales/**/*.{rb,yml}", __FILE__)]
     
    initializer 'configure ember-rails ranking', before: 'ember_rails.setup_vendor' do
      config.handlebars.templates_root << 'voluntary_brainstorming/templates'
    end
    
    config.to_prepare do
      User.send :include, VoluntaryBrainstorming::Concerns::Model::User::HasBrainstormings
      Argument.send :include, VoluntaryBrainstorming::Concerns::Model::Argument::PublishesChangesToBrainstorming
    end
  end
end

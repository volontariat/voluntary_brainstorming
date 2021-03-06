module VoluntaryBrainstorming
  module Concerns
    module Model
      module Argument
        module PublishesChangesToBrainstorming
          extend ActiveSupport::Concern
          
          included do
            after_create :publish_create_to_brainstorming
            after_update :publish_update_to_brainstorming
            before_destroy :publish_destroy_to_brainstorming
            
            private
            
            def publish_create_to_brainstorming
              return if Rails.env.test? || Rails.env.cucumber?
              return unless argumentable_type == 'BrainstormingIdea'
              
              MessageBus.publish(
                "/brainstormings/#{argumentable.brainstorming.slug}", 
                { author_id: user_id, message: "#{I18n.t('arguments.model.publish_create_to_brainstorming')}: #{topic.name}" }
              )
            end
            
            def publish_update_to_brainstorming
              return if Rails.env.test? || Rails.env.cucumber?
              return unless argumentable_type == 'BrainstormingIdea'
              
              MessageBus.publish(
                "/brainstormings/#{argumentable.brainstorming.slug}", 
                { author_id: user_id, message: "#{I18n.t('arguments.model.publish_update_to_brainstorming')}: #{topic.name}" }
              )
            end
            
            def publish_destroy_to_brainstorming
              return if Rails.env.test? || Rails.env.cucumber?
              return unless argumentable_type == 'BrainstormingIdea'
              
              MessageBus.publish(
                "/brainstormings/#{argumentable.brainstorming.slug}", 
                { author_id: user_id, message: "#{I18n.t('arguments.model.publish_destroy_to_brainstorming')}: #{topic.name}" }
              )
            end
          end
        end
      end
    end
  end
end
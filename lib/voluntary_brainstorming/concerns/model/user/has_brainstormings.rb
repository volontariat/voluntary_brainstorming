module VoluntaryBrainstorming
  module Concerns
    module Model
      module User
        module HasBrainstormings
          extend ActiveSupport::Concern
          
          included do
            has_many :brainstormings
            has_many :brainstorming_ideas
            has_many :brainstorming_idea_votes
          end
        end
      end
    end
  end
end
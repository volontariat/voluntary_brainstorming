class BrainstormingIdeaVote < ActiveRecord::Base
  belongs_to :idea, class_name: 'BrainstormingIdea', counter_cache: 'votes_count'
  belongs_to :user
  
  attr_accessible :idea_id
end
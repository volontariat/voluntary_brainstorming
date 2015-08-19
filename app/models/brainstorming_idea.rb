class BrainstormingIdea < ActiveRecord::Base
  belongs_to :brainstorming
  belongs_to :user
  
  has_many :arguments, as: :argumentable
  has_many :votes, class_name: 'BrainstormingIdeaVote'
  
  validates :brainstorming_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :brainstorming_id }
  
  attr_accessible :brainstorming_id, :name, :text
end
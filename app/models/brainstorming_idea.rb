class BrainstormingIdea < ActiveRecord::Base
  belongs_to :brainstorming
  belongs_to :user
  
  has_many :arguments, as: :argumentable, dependent: :destroy
  has_many :votes, class_name: 'BrainstormingIdeaVote', dependent: :destroy, foreign_key: 'idea_id'
  
  validates :brainstorming_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :brainstorming_id }
  
  attr_accessible :brainstorming_id, :name, :text
  
  after_save :publish
  
  private
  
  def publish
    MessageBus.publish("/brainstormings/#{brainstorming.slug}", to_json)
  end
end
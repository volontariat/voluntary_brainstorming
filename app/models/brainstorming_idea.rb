class BrainstormingIdea < ActiveRecord::Base
  belongs_to :brainstorming
  belongs_to :user
  
  has_many :arguments, as: :argumentable, dependent: :destroy
  has_many :votes, class_name: 'BrainstormingIdeaVote', dependent: :destroy, foreign_key: 'idea_id'
  
  scope :with_current_user_vote, ->(user_id) do
    select('brainstorming_ideas.*, brainstorming_idea_votes.user_id AS vote').joins(
      'LEFT JOIN brainstorming_idea_votes ON brainstorming_idea_votes.idea_id = brainstorming_ideas.id AND ' +
      "brainstorming_idea_votes.user_id = #{sanitize(user_id)}"
    )  
  end
  
  validates :brainstorming_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :brainstorming_id }
  
  attr_accessible :brainstorming_id, :name, :text
  
  after_create :publish_create
  after_update :publish_update
  after_destroy :publish_destroy
  
  private
  
  def publish_create
    return if Rails.env.test? || Rails.env.cucumber?
    
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { author_id: user_id, message: "#{I18n.t('brainstorming_ideas.model.publish_create')}: #{name}" }
    )
  end
  
  def publish_update
    return if Rails.env.test? || Rails.env.cucumber?
    
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { author_id: user_id, message: "#{I18n.t('brainstorming_ideas.model.publish_update')}: #{name}" }
    )
  end
  
  def publish_destroy
    return if Rails.env.test? || Rails.env.cucumber?
    
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { author_id: user_id, message: "#{I18n.t('brainstorming_ideas.model.publish_destroy')}: #{name}" }
    )
  end
end
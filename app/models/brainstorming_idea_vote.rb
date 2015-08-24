class BrainstormingIdeaVote < ActiveRecord::Base
  belongs_to :idea, class_name: 'BrainstormingIdea', counter_cache: 'votes_count'
  belongs_to :user
  
  validates :idea_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :idea_id }
  
  attr_accessible :idea_id
  
  after_create :publish_create
  after_destroy :publish_destroy
  
  private
  
  def publish_create
    return if Rails.env.test? || Rails.env.cucumber?
    
    MessageBus.publish(
      "/brainstormings/#{idea.brainstorming.slug}", 
      { author_id: user_id, message: "#{I18n.t('brainstorming_idea_votes.model.publish_create')}: +1 #{idea.name} by #{user.name}" }
    )
  end
  
  def publish_destroy
    return if Rails.env.test? || Rails.env.cucumber?
    
    MessageBus.publish(
      "/brainstormings/#{idea.brainstorming.slug}", 
      { author_id: user_id, message: "#{I18n.t('brainstorming_idea_votes.model.publish_destroy')}: -1 #{idea.name} by #{user.name}" }
    )
  end
end
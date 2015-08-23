class BrainstormingIdea < ActiveRecord::Base
  belongs_to :brainstorming
  belongs_to :user
  
  has_many :arguments, as: :argumentable, dependent: :destroy
  has_many :votes, class_name: 'BrainstormingIdeaVote', dependent: :destroy, foreign_key: 'idea_id'
  
  validates :brainstorming_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :brainstorming_id }
  
  attr_accessible :brainstorming_id, :name, :text
  
  after_create :publish_create
  after_update :publish_update
  after_destroy :publish_destroy
  
  private
  
  def publish_create
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { message: "#{I18n.t('brainstorming_ideas.model.publish_create')}: #{name}" }
    )
  end
  
  def publish_update
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { message: "#{I18n.t('brainstorming_ideas.model.publish_update')}: #{name}" }
    )
  end
  
  def publish_destroy
    MessageBus.publish(
      "/brainstormings/#{brainstorming.slug}", 
      { message: "#{I18n.t('brainstorming_ideas.model.publish_destroy')}: #{name}" }
    )
  end
end
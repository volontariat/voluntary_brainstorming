class Brainstorming < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :user
  
  has_many :ideas, class_name: 'BrainstormIdea'
  
  friendly_id :name, use: :scoped, scope: :user
  
  attr_accessible :name, :text
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :user_id }
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
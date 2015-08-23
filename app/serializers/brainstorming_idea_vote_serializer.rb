class BrainstormingIdeaVoteSerializer < ActiveModel::Serializer
  attributes :id, :idea_id, :user_id, :user_slug, :user_name

  def user_slug
    object.user.try(:slug)
  end
  
  def user_name
    object.user.try(:name)
  end
end
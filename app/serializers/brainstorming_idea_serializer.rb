class BrainstormingIdeaSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_slug, :user_name, :name, :text

  def user_slug
    object.user.try(:slug)
  end
  
  def user_name
    object.user.try(:name)
  end
end
class BrainstormingIdeaSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_slug, :user_name, :name, :text, :arguments, :votes_count, :vote

  def user_slug
    object.user.try(:slug)
  end
  
  def user_name
    object.user.try(:name)
  end
  
  def arguments
    object.arguments.map{|a| ArgumentSerializer.new(a)}
  end
end
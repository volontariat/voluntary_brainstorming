class BrainstormingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_slug, :name, :slug, :text

  def user_slug
    object.user.try(:slug)
  end
end
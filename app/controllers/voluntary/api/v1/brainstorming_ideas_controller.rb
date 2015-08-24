class Voluntary::Api::V1::BrainstormingIdeasController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    user = User.friendly.find params[:user_slug]
    collection = user.brainstormings.friendly.find(params[:brainstorming_slug]).ideas.order('votes_count DESC').includes(:user)
    collection = collection.with_current_user_vote(current_user.id) if current_user  
    collection = collection.to_a
    
    collection.each_with_index do |resource, index|
      arguments = resource.arguments.includes(:user, :topic).to_a
      
      if current_user
        argument_likes = Argument.likes_or_dislikes_for(current_user, arguments.map(&:id))
        
        arguments.map! do |argument|
          argument.positive = argument_likes[argument.id].try(:positive)
          argument
        end
      end
      
      resource.arguments = arguments
      collection[index] = resource
    end
    
    respond_with do |format|
      format.json { render json: collection }
    end
  end
  
  def create
    params[:brainstorming_idea][:brainstorming_id] = User.friendly.find(params[:user_slug]).brainstormings.friendly.find(params[:brainstorming_slug]).id
    resource = current_user.brainstorming_ideas.create params[:brainstorming_idea]
    
    respond_to do |format|
      format.json do
        if resource.persisted?
          render json: {}
        else 
          render json: { errors: resource.errors.to_hash }
        end
      end
    end
  end
  
  def update
    resource = current_user.brainstorming_ideas.find params[:id]
    resource.update_attributes params[:brainstorming_idea]
    
    respond_to do |format|
      format.json do
        if resource.valid?
          render json: {}
        else 
          render json: { errors: resource.errors.to_hash }
        end
      end
    end
  end
  
  def destroy
    resource = current_user.brainstorming_ideas.find params[:id]
    resource.destroy
    
    respond_to do |format|
      format.json do
        if resource.persisted?
          render json: { error: I18n.t('activerecord.errors.models.brainstorming_idea.attributes.base.deletion_failed') }
        else
          render json: {}
        end
      end
    end
  end
end
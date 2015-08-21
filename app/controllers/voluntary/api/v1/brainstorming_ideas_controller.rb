class Voluntary::Api::V1::BrainstormingIdeasController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    user = User.friendly.find params[:user_slug]
    respond_with do |format|
      format.json { render json: user.brainstormings.friendly.find(params[:brainstorming_slug]).ideas.includes(:user) }
    end
  end
  
  def create
    params[:brainstorming_idea][:brainstorming_id] = User.friendly.find(params[:user_slug]).brainstormings.friendly.find(params[:brainstorming_slug]).id
    resource = current_user.brainstorming_ideas.create params[:brainstorming_idea]
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    resource = current_user.brainstorming_ideas.find params[:id]
    resource.update_attributes params[:brainstorming_idea]
    
    respond_to do |format|
      format.json do
        render json: resource.valid? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    resource = current_user.brainstorming_ideas.find params[:id]
    resource.destroy
    
    respond_to do |format|
      format.json do
        render json: if resource.persisted?
          { error: I18n.t('activerecord.errors.models.brainstorming_idea.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end
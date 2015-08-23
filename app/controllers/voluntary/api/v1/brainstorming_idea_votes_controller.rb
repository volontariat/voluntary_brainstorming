class Voluntary::Api::V1::BrainstormingIdeaVotesController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    idea = BrainstormingIdea.friendly.find params[:idea_id]
    respond_with do |format|
      format.json { render json: idea.votes.includes(:user) }
    end
  end
  
  def create
    resource = current_user.brainstorming_idea_votes.create idea_id: params[:idea_id]
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    resource = current_user.brainstorming_idea_votes.where(idea_id: params[:idea_id]).first
    raise ActiveRecord::RecordNotFound unless resource
    resource.destroy
    
    if resource.persisted?
      raise I18n.t('activerecord.errors.models.brainstorming_idea_vote.attributes.base.deletion_failed') 
    end
     
    respond_to do |format|
      format.json do
        render json: {}
      end
    end
  end
end
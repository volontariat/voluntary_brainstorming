class Voluntary::Api::V1::BrainstormingsController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    user = User.friendly.find params[:user_slug]
    collection = user.brainstormings
    options[:json] = collection.paginate page: params[:page], per_page: 10
    
    options[:meta] = { 
      pagination: {
        total_pages: options[:json].total_pages, current_page: options[:json].current_page,
        previous_page: options[:json].previous_page, next_page: options[:json].next_page
      }
    }
    
    respond_with do |format|
      format.json { render options }
    end
  end
  
  def show
    user = User.friendly.find(params[:user_slug])
    
    respond_to do |format|
      format.json do
        render json: user.brainstormings.friendly.find(params[:id])
      end
    end
  end
  
  def create
    brainstorming = current_user.brainstormings.create params[:brainstorming]
    
    respond_to do |format|
      format.json do
        render json: brainstorming.persisted? ? brainstorming : { errors: brainstorming.errors.to_hash }
      end
    end
  end
  
  def update
    brainstorming = current_user.brainstormings.friendly.find params[:id]
    brainstorming.update_attributes params[:brainstorming]
    
    respond_to do |format|
      format.json do
        render json: brainstorming.valid? ? brainstorming : { errors: brainstorming.errors.to_hash }
      end
    end
  end
  
  def destroy
    brainstorming = current_user.brainstormings.friendly.find params[:id]
    brainstorming.destroy
    
    respond_to do |format|
      format.json do
        render json: if brainstorming.persisted?
          { error: I18n.t('activerecord.errors.models.brainstorming.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end
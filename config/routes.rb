Rails.application.routes.draw do
  get '/products/brainstorming' => 'product/brainstorming#index'
  
  namespace :voluntary, path: 'api', module: 'voluntary/api', defaults: {format: 'json'} do
    namespace :v1 do
      resources :brainstormings, only: [:index, :create, :show, :update, :destroy]
      resources :brainstorming_ideas, only: [:index, :create, :update, :destroy]
      resources :brainstorming_idea_votes, only: [:index, :create, :destroy]
    end
  end
end

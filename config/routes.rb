Rails.application.routes.draw do
  get '/products/brainstorming' => 'product/brainstorming#index'
  
  namespace :voluntary, path: 'api', module: 'voluntary/api', defaults: {format: 'json'} do
    namespace :v1 do
      resources :brainstormings, only: [:index, :create, :show, :update, :destroy]
    end
  end
end

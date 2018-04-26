Rails.application.routes.draw do
  resources :attachments do
    collection do
      get :download
    end
  end
  resources :types
  root to: 'visitors#index'
  devise_for :users
  resources :users
end

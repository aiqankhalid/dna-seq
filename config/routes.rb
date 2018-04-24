Rails.application.routes.draw do
  resources :attachments
  resources :types
  root to: 'visitors#index'
  devise_for :users
  resources :users
end

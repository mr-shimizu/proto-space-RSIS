Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: [:index, :show], param: :tag_name
end

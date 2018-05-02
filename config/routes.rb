Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: [:index, :show], param: :tag_name
  resources :prototypes do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
end

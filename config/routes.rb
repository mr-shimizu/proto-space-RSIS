Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:show, :edit, :update]
  resources :prototypes do
    resources :likes, only: [:create, :destroy]
  end
end

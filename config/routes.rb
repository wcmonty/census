Rails.application.routes.draw do
  get 'categorizer/index'
  get 'statistics/index'

  get 'home/index'
  root 'home#index'

  resources :people, only: [:index, :new, :edit, :create, :update, :destroy]
end
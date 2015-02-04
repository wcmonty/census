Rails.application.routes.draw do
  get 'people/categorize'
  get 'statistics/index'

  get 'home/index'
  root 'home#index'

  resources :people, only: [:index, :new, :edit, :create, :update, :destroy]
end
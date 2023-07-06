Rails.application.routes.draw do
  resources :foods

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_scope :user do
    get '/users/logout', to: 'devise/sessions#destroy', as: :logout
  end
  devise_for :users
  resources :recipes
  get '/recipe_visibility/:id', to: 'recipes#toggle_visibility', as: :visibility
  get '/shopping_list', to: 'recipes#shopping_list', as: :shopping_list
  resources :foods, except: %i[show edit update]
end

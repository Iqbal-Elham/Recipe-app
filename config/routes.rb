Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "recipes#public_recipes"
  
  devise_for :users
  resources :recipes, except: %i[edit update]

  # get '/public_recipes', to: 'recipes#public_recipes'

end

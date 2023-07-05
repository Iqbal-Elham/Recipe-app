Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  devise_scope :user do
    get '/users/logout', to: 'devise/sessions#destroy', as: :logout
  end
  devise_for :users
  resources :recipes, except: %i[edit update]

end

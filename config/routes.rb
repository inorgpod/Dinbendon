Rails.application.routes.draw do
  resources :categories
  resources :items



  # get "/login" , to: "welcome#login"
  
  get "/login", to: "users#login"
  post "/login", to: "users#sign_in"
  delete "/logout", to: "users#logout"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up" , to: "users#registration" 
  
  root "welcome#index"

  # resources :login
end


Rails.application.routes.draw do
  resources :categories

  resources :items do 
    resources :comments , only: [:create] #巢狀路徑 通常不會超過兩層 因為網址會太複雜 ,only: 就是把原本七個路徑控制只剩create的路徑

    #/items/??????
  end
  #resources :comments



  # get "/login" , to: "welcome#login"
  
  get "/login", to: "users#login"
  post "/login", to: "users#sign_in"
  delete "/logout", to: "users#logout"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up" , to: "users#registration" 
  
  root "welcome#index"

  # resources :login


  #API
  namespace :api do
    namespace :v1 do
      resources :items , only: [] do
        member do
          # 這個裡面的路徑會帶ID
        post :favorite
        # post => /items/2/favorited
      end
        collection do
          # 這個裡面的路徑不會帶ID
        get :all
        # get => /items/all
        end
      end
    end
  end
end


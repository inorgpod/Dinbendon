Rails.application.routes.draw do
  root "welcome#index"

  resources :categories

  resources :items do 
    member do
      post :add_to_cart
    end 
    resources :comments , only: [:create] #巢狀路徑 通常不會超過兩層 因為網址會太複雜 ,only: 就是把原本七個路徑控制只剩create的路徑
  
  end
  
  #cart 
  #post "/abc/:id", to: "cart/#add" , as: :cc
  resource :cart, only: [:show, :destroy] do 
    collection do 
      get :checkout
    end
  end 
  # get "/login" , to: "welcome#login"


  resource :checkout, only: [:index, :show,  :create] do 
    member do 
      delete :cancel
    end
  end

  #users
  get "/login", to: "users#login"
  post "/login", to: "users#sign_in"
  delete "/logout", to: "users#logout"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up" , to: "users#registration" 
  
 



  #APIs
  namespace :api do
    namespace :v1 do
      resources :items , only: [] do
        member do
          # 這個裡面的路徑會帶ID
            post :favorite
        # post => /items/2/favorited
        #collection do
          # 這個裡面的路徑不會帶ID
        #get :all
        # get => /items/all
        end
      end
    end
  end
end


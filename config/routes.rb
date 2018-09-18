Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :country
      resources :product_categories
      resources :product_masters
      resources :terminals
      resources :sale
      resources :currencies
      resources :customers
      resources :banners
      resources :menus
      resources :user_master
      #get 'stocks', to: 'stock#index'
      resources :stock
      get 'sales', to: 'sale#index'
      post 'login' , to: 'authenticates#login'
    end
  end
end

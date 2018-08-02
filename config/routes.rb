Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :country
      resources :product_categories
      resources :product_masters
      get 'stocks', to: 'stock#index'
      get 'sales', to: 'sale#index'
    end
  end

end

Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :country
      resources :product_categories
      resources :product_masters
    end
  end

end

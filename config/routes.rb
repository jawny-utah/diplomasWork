Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#index"
  resources :pages do
    collection do
      get :delivery_info
      get :payment_info
    end
  end
  resources :wears
  resources :orders do
    collection do
      get :show_cart_modal
    end
  end

  resource :checkouts
  put "/submit_order/:id", to: "checkouts#submit_order", as: "submit_order"
  resources :wear_order_detail_sizes
  resources :users do
    collection do
      post :login
    end
  end
end

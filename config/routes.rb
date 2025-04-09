Rails.application.routes.draw do
  get "orders/index"
  get "orders/show"
  get "categories/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # admin dashboard (ActiveAdmin)
  resources :products, only: [ :index, :show ]

  # Products
  resources :products, only: [ :index, :show ]

  # Categories
  resources :categories, only: [ :show ]

  # Cart
  resource :cart, only: [] do
    get "succcess"
    get "cancel"
    post "add/:product_id", to: "cart#add", as: "add_to"
    delete "remove/:product_id", to: "carts#remove", as: "remove_from"
    patch "update/:product_id", to: "carts#update", as: "update_item"
  end

  # Checkout
  resources :checkouts, only: [ :create ]

  # Orders
  resources :orders, only: [ :index, :show ]

  # Reviews
  resources :reviews, only: [ :create ]

  # Root
  root "products#index"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

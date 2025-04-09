Rails.application.routes.draw do
  get "pages/home"
  root "pages#home"
  # Devise for users & admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # admin dashboard (ActiveAdmin)
  resources :products, only: [ :index, :show ]

  # Products
  resources :products, only: [ :index, :show ]

  # Categories
  resources :categories, only: [ :show ]

  # Cart (no HTML view, just actions)
  resource :cart, only: [] do
    get "success"
    get "cancel"
    post "add/:product_id", to: "carts#add", as: "add_to"
    delete "remove/:product_id", to: "carts#remove", as: "remove_from"
    patch "update/:product_id", to: "carts#update", as: "update_item"
  end

  # Checkout
  resources :checkouts, only: [ :create ]

  # Orders
  resources :orders, only: [ :index, :show ]

  # Reviews
  resources :reviews, only: [ :create ]

  # Root path
  root "products#index"
end

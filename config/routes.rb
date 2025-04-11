Rails.application.routes.draw do
  # Devise for users & admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Dynamic pages like /pages/about or /pages/contact
  get "/pages/:slug", to: "pages#show", as: :page

  # Products
  resources :products, only: [ :index, :show ] do
    resources :reviews, only: [ :create ]
  end

  # Categories
  resources :categories, only: [ :index, :show ]

  # Cart (no HTML view, just actions)
  resource :cart, only: [ :show ] do
    get "success"
    get "cancel"
    post "add/:product_id", to: "carts#add", as: "add_to"
    delete "remove/:product_id", to: "carts#remove", as: "remove_from"
    patch "update/:product_id", to: "carts#update", as: "update_item"
  end

  # Checkout
  resources :checkouts, only: [ :create ]
  get "checkout/success", to: "checkouts#success", as: "success"
  get "checkout/cancel", to: "checkouts#cancel", as: "cancel"

  # Orders
  resources :orders, only: [ :index, :show ]

  # Admin routes
  namespace :admin do
    resources :orders
    resources :products
    resources :categories
  end

  # Reviews
  resources :reviews, only: [ :create ]

  # Root path
  root "pages#home"
end

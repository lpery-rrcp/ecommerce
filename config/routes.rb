Rails.application.routes.draw do
  # Devise for Admin and Regular Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Dynamic Content Pages (e.g., /pages/about or /pages/contact)
  get "/pages/:slug", to: "pages#show", as: :page

  # Root Path
  root "pages#home"

  # Products and Reviews
  resources :products, only: [ :index, :show ] do
    resources :reviews, only: [ :create ]
  end

  # Standalone Reviews (if needed)
  resources :reviews, only: [ :create ]

  # Categories
  resources :categories, only: [ :index, :show ]

  # Cart Routes
  resource :cart, only: [ :show ] do
    get "success"
    get "cancel"
    post "add/:product_id", to: "carts#add", as: "add_to"
    delete "remove/:product_id", to: "carts#remove", as: "remove_from"
    patch "update/:product_id", to: "carts#update", as: "update_item"
  end

  # Checkout Routes
  resources :checkouts, only: [ :create ]
  get "checkout/success", to: "checkouts#success", as: "success"
  get "checkout/cancel", to: "checkouts#cancel", as: "cancel"

  # Orders for Users
  resources :orders, only: [ :index, :show ]

  # Pages
  get "/about",   to: "pages#show", defaults: { slug: "about" }
  get "/contact", to: "pages#show", defaults: { slug: "contact" }

  # Admin Namespace (explicitly declared if extended later)
  namespace :admin do
    resources :orders
    resources :products
    resources :categories
    # ActiveAdmin adds more here
  end
end

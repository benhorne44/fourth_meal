DinnerDash::Application.routes.draw do

  resources :items
  resources :orders
  resources :order_items
  resources :users
  resources :categories
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :charges
  resources :restaurants
  root to: 'restaurants#index'

  post "items/add_to_order/:id" => 'items#add_to_order', as: 'add_item'
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"

  post "checkout/:id" => "orders#checkout", as: 'checkout'
  post "checkout_all" => "orders#checkout_all", as: 'checkout_all'
  post "place_order" => "orders#place_order", as: 'place_order'

  get "dashboard" => "users#dashboard", as: 'dashboard'
  get "cart" => "carts#index", as: "cart"
end


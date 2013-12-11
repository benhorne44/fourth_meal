DinnerDash::Application.routes.draw do

  resources :items
  resources :orders
  resources :order_items
  resources :users
  resources :categories
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :restaurants
  root to: 'restaurants#index'

  post "items/add_to_order/:id" => 'items#add_to_order', as: 'add_item'
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"
  get "login_options" => "user_sessions#options", as: "login_options"
  post "submit_guest" => "user_sessions#submit_guest", as: "submit_guest"
  post "login_to_checkout" => 'user_sessions#login_to_checkout'

  post "checkout/:id" => "orders#checkout", as: 'checkout'
  get "checkout/:id" => "orders#checkout"
  post "checkout_all" => "orders#checkout_all", as: 'checkout_all'
  get "checkout_all" => "orders#checkout_all"
  post "place_order" => "orders#place_order", as: 'place_order'

  get "dashboard" => "users#dashboard", as: 'dashboard'
  get "cart" => "carts#index", as: "cart"

  get 'multiple_new' => 'charges#multiple_new', as: 'multiple_order_charge'
  post 'charges_all' => 'charges#charges_all', as: 'charges_all'
  post 'charges/:id' => 'charges#create', as: 'charges'
end


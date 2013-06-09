Blog::Application.routes.draw do
  root :to => 'posts#index'

  resources :users, only: [:edit, :update]
  resources :sessions

  get "login"  => "sessions#new",     :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :posts
    get "personal_index" => "posts#personal_index", :as => "personal_index"

  resources :tags

  get "about_me"  => "extras#about_me",  :as => "about_me"
  get "resume"    => "extras#resume",    :as => "resume"
  get "portfolio" => "extras#portfolio", :as => "portfolio"
end

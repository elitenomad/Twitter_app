SampleApp::Application.routes.draw do

  get "relationships/create"
  get "relationships/destroy"
  root 'static_pages#home'
  
  resources :users do

     member do
        get :following, :followers
      end

  end


  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "help" => "static_pages#help"
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"
end

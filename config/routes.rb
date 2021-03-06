SampleApp::Application.routes.draw do

  get '/hashtags/:id/show', to: 'hashtags#show' , as: 'hashtag'
  # get '/search', to:'users#search', as:'search_user'
  # get '/qresults', to:'users#qresults', as:'query_user'
  get '/hashtags', to: 'hashtags#index'
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
  get "sendemail" => "static_pages#sendemail"
  get "help" => "static_pages#help"
  get "terms" => "static_pages#terms"
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  delete "signout" => "sessions#destroy"
end

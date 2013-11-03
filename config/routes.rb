Cora::Application.routes.draw do
  root :to => "home#index"
  get '/auth/:provider/callback', to: 'omniauth_session#create'
  post '/auth/:provider/callback', to: 'omniauth_session#create'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  mount Cora::Engine => Cora.path, :as => :cora_engine

end

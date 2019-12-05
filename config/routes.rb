Rails.application.routes.draw do

  resources :users
  namespace :api do
    namespace :v1 do
      resources :versions
      resources :songs
      resources :albums

      get 's3/direct_post'
      get 's3/signed_url'
      get 's3/list_objects'

      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

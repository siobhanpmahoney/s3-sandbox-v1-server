Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :versions
      resources :songs
      resources :albums

      get 's3/direct_post'
      get 's3/signed_url'
      get 's3/list_objects'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
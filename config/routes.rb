Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create]
      post 'user_token' => 'user_token#create'
      namespace :guest do
        resources :conversions, only: [:index]
      end
    end
  end
end

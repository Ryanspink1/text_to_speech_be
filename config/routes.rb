Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create, :index, :update]
      post 'user_token' => 'user_token#create'
      scope '/users' do
        resources :conversions, only: [:create]
      end
      resources :conversions, only: [:index, :destroy]
      namespace :guest do
        resources :conversions, only: [:index]
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup' => 'users#signup'
      post '/login' => 'sessions#login'

      resources :users, only: [:index, :show, :update]
      resources :chatrooms, only: [:index, :show, :create, :destroy] do
      end

      mount ActionCable.server => '/cable'
    end
  end
end

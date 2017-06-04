Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup' => 'users#signup'
      post '/login' => 'sessions#login'

      resources :users, only: [:index, :show]
      resources :chatrooms, only: [:index, :show, :create] do
        post '/users' => 'user_chatrooms#create'
      end

      resources :suggestions, only: [:destroy]

      # resource :profile, only: [:update]
      mount ActionCable.server => '/cable'
    end
  end
end

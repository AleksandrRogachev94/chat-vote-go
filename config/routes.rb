Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup' => 'users#signup'
      post '/login' => 'sessions#login'

      resources :users, only: [:index, :show, :update]
      resources :chatrooms, only: [:index, :show, :create] do
        post '/users' => 'user_chatrooms#create'
        delete '/users/:id' => 'user_chatrooms#destroy'
      end

      resources :suggestions, only: [:destroy]

      mount ActionCable.server => '/cable'
    end
  end
end

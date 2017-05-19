Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup' => 'users#signup'
      post 'login' => 'sessions#login'

      resources :users, only: [:index, :show]
      resources :chatrooms, only: [:index, :show] do
        resources :messages, only: [:create]
      end

      # resource :profile, only: [:update]
    end
  end
end

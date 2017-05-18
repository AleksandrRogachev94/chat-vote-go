Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup' => 'users#signup'
      resources :users, only: [:index, :show]
      

      post 'login' => 'sessions#login'
      # resource :profile, only: [:update]
    end
  end
end

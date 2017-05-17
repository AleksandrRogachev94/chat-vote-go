Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup' => 'users#signup'
      get 'users/:id' => 'users#show' 
      post 'login' => 'sessions#login'
      get 'test' => 'users#test'
      # resource :profile, only: [:update]
    end
  end
end

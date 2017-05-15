Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup' => 'users#signup'
      post 'login' => 'sessions#login'
      get 'test' => 'users#test'
    end
  end
end

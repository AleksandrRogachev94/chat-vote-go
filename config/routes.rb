Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup' => 'users#signup'
      post 'login' => 'sessions#login'
    end
  end
end

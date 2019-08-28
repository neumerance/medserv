Rails.application.routes.draw do
  root to: 'landing#index'
  devise_for :users

  namespace :admin do
    resources :users
    resources :clients do
      resources :client_records
    end
  end
end

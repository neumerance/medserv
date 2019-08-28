Rails.application.routes.draw do
  root to: 'landing#index'
  devise_for :users

  resources :clients do
    resources :client_records
  end

  namespace :admin do
    resources :users
  end
end

Rails.application.routes.draw do
  root to: 'landing#index'
  namespace :admin do
    resources :clients do
      resources :client_records
    end
  end
end

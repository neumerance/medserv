Rails.application.routes.draw do
  namespace :admin do
    resources :clients do
      resources :client_records
    end
  end
end

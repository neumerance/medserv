Rails.application.routes.draw do
  namespace :admin do
    resources :clients
  end
end

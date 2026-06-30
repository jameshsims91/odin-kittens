Rails.application.routes.draw do
  root "kittens#index"
  resources :kittens
  get "up" => "rails/health#show", as: :rails_health_check
end

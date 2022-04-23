Rails.application.routes.draw do
  post "/signup", to: "user#create"
  get "/me", to: "user#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :recipes, only: [:index, :create]
end

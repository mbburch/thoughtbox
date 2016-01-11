Rails.application.routes.draw do

  root 'welcome#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  delete "/logout", to: "sessions#destroy"
  resources :links

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end

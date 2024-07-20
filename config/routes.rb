# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create update]

      resources :users do
        member do
          get "teams"
        end
      end

      resources :teams, only: %i[index show create update]

      resources :teams do
        member do
          post "add_user"
          delete "remove_user"
          get "users"
        end
      end

      resources :categories, only: %i[index show create update]

      resources :tasks, only: %i[index show create update]
    end
  end
end

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "top#index"
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  get "signup", to: "users#new", as: "signup"
  get '/survey', to: 'top#survey'
  get '/survey_step2', to: 'top#survey_step2'
end

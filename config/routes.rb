Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "top#index"
  resources :users, only: [ :new, :create, :show ] do
    member do
      get :mypage
    end
  end
  resources :diagnoses, only: [ :create, :show ]
  resources :sauna_facilities, only: [ :index ]

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "signup", to: "users#new", as: "signup"
  get "/survey", to: "top#survey"
  get "/survey_step2", to: "top#survey_step2"
end

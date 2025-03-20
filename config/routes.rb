Rails.application.routes.draw do
  root "top#index"

  resources :users, only: [ :new, :create, :show ] do
    member do
      get :mypage
    end
  end

  resources :diagnoses, only: [ :create, :show ]
  resources :sauna_facilities, only: [ :index, :show ]

  get "/survey", to: "diagnoses#survey"
  post "/survey/answer", to: "diagnoses#answer"

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "signup", to: "users#new", as: "signup"
  get "/maintenance", to: "pages#maintenance", as: "maintenance"
  post "/survey/finish", to: "diagnoses#create", as: :survey_finish
end

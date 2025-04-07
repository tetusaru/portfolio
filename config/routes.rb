Rails.application.routes.draw do
  get "mysaunas/new"
  get "mysaunas/create"
  get "mysaunas/edit"
  get "mysaunas/update"
  get "mysaunas/destroy"
  root "top#index"

  resources :users, only: [ :new, :create, :show ] do
    member do
      get :mypage
      get :share
    end
  end

  resources :mysaunas, only: [ :new, :create, :edit, :update, :destroy, :show ] do
    member do
      get :share, to: "mysaunas#show_share" # OGP用
    end
  end

  resources :diagnoses, only: [ :create, :show ]
  resources :sauna_facilities, only: [ :index, :show ]
  resources :posts, only: [ :index, :create, :destroy, :show ]

  get "/survey", to: "diagnoses#survey"
  post "/survey/answer", to: "diagnoses#answer"
  post "/survey/finish", to: "diagnoses#create", as: :survey_finish

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "signup", to: "users#new", as: "signup"
  get "/maintenance", to: "pages#maintenance", as: "maintenance"
  get "/password_reset", to: "password_resets#edit", as: :edit_password_reset
  patch "/password_reset", to: "password_resets#update"
end

Rails.application.routes.draw do
  get "mysaunas/new"
  get "mysaunas/create"
  get "mysaunas/edit"
  get "mysaunas/update"
  get "mysaunas/destroy"

  root "top#index"

  get "/privacy", to: "pages#privacy", as: :privacy_policy
  get "/terms", to: "pages#terms", as: :terms_of_service
  get "/contact", to: "pages#contact", as: :contact

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
  resources :favorites, only: [ :create ]
  delete "/favorites", to: "favorites#destroy", as: :delete_favorite

  get "/survey", to: "diagnoses#survey"
  post "/survey/answer", to: "diagnoses#answer"
  post "/survey/finish", to: "diagnoses#create", as: :survey_finish

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  get "/auth/:provider", to: "sessions#passthru", as: :auth_request
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "logout", to: "user_sessions#destroy"
  get "signup", to: "users#new", as: "signup"
  get "/maintenance", to: "pages#maintenance", as: "maintenance"

  # パスワードリセット関連
  get   "/password_reset_request",           to: "password_resets#new",    as: :new_password_reset
  post  "/password_reset_request",           to: "password_resets#create", as: :password_resets
  get   "/password_reset/:token",            to: "password_resets#edit",   as: :edit_password_reset
  patch "/password_reset/:token",            to: "password_resets#update", as: :password_reset
end

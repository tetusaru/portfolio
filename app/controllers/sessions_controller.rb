class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :passthru, :create, :failure ]

  def passthru
      render plain: "Not found. Authentication passthru.", status: :not_found
  end

  def create
    auth = request.env[ "omniauth.auth" ]
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "ログイン成功！"
  end

  def failure
    redirect_to root_path, alert: "ログインに失敗しました。"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました。"
  end
end

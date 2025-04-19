class SessionsController < ApplicationController
  include Sorcery::Controller
  include Sorcery::Controller::Submodules::RememberMe

  skip_before_action :require_login, only: [ :passthru, :create, :failure ]

  def passthru
    render plain: "Not found. Authentication passthru.", status: :not_found
  end

  def create
    auth = request.env["omniauth.auth"]

    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
    end

    user.remember_me!
    auto_login(user)

    redirect_to root_path, notice: "ログイン成功！"
  end

  def failure
    redirect_to root_path, alert: "ログインに失敗しました。"
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました。"
  end
end

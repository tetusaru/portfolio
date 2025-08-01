class SessionsController < ApplicationController
  include Sorcery::Controller

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
    user.save!

    auto_login(user)
    set_remember_me_cookie(user)

    redirect_to root_path, notice: "ログイン成功！"
  end

  def failure
    redirect_to root_path, alert: "ログインに失敗しました。"
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました。"
  end

  private

  def set_remember_me_cookie(user)
    cookies.signed[:remember_me_token] = {
      value: user.remember_me_token,
      expires: user.remember_me_token_expires_at,
      httponly: true,
      secure: Rails.env.production?
    }
  end
end

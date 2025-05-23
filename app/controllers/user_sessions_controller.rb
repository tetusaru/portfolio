class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember_me] == "1")
    puts "login result @user = #{@user.inspect}"

    if @user
      redirect_to root_path, notice: "ログインされました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました。"
  end
end

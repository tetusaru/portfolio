class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def edit
  end

  def update
    @user = User.find_by(email: params[ :user ][ :email ])
    if @user && @user.update(password_params)
      redirect_to login_path, notice: "パスワードを変更しました。ログインしてください。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
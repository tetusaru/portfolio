class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def edit
  end

  def update
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.update(password_params)
      redirect_to login_path, notice: "パスワードを変更しました。ログインしてください。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      begin
        @user.deliver_reset_password_instructions!
        Rails.logger.info "[PasswordReset] メール送信成功"
      rescue => e
        Rails.logger.error "[PasswordReset] メール送信失敗: #{e.message}"
      end
      redirect_to root_path, notice: "パスワードリセット用メールを送信しました。"
    else
      flash.now[:alert] = "メールアドレスが見つかりませんでした。"
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

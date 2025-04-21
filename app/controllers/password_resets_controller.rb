class PasswordResetsController < ApplicationController
  skip_before_action :require_login, only: [ :edit, :update, :create ]

  def edit
    @user = User.load_from_reset_password_token(params[:token])
    unless @user
      redirect_to root_path, alert: "トークンが無効または期限切れです。"
    end
  end

  def update
    @user = User.load_from_reset_password_token(params[:token])

    unless @user
      redirect_to root_path, alert: "トークンが無効または期限切れです。" and return
    end

    @user.password = password_params[:password]
    @user.password_confirmation = password_params[:password_confirmation]

    if @user.save
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
        @user.reload

        Rails.logger.info "[PasswordReset] メール送信成功: #{@user.reset_password_token}"
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

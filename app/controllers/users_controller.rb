class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :require_login, only: [ :mypage ]

  def new
    @user = User.new
  end

  def create
    Rails.logger.debug "User registration params: #{params[:user].inspect}" # デバッグ用ログ
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "ユーザーが登録されました。ログインしてみましょう！"
    else
      render :new
    end
  end

  def share
    @user = User.find(params[:id])
    @mysauna = @user.mysauna
    if @mysauna.present?
      @ogp_image = @mysauna.image
      render layout: "ogp", inline: "" # ここで view を空にして ogp レイアウトだけを返す
    else
      redirect_to mypage_user_path(@user), alert: "Mysaunaが登録されていません。"
    end
  end

  def mypage
    @user = current_user
    @mysauna = @user.mysauna
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

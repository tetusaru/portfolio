class ApplicationController < ActionController::Base
  include Sorcery::Controller

  before_action :auto_login_from_cookie
  before_action :require_login, unless: :public_action?

  private

  def auto_login_from_cookie
    Rails.logger.info ">>> auto_login_from_cookie called"
    return if logged_in?

    user = login_from_cookie
    if user
      @current_user = user
      Rails.logger.info ">>> auto-login success for user=#{user.id}"
    else
      Rails.logger.info ">>> auto-login failed"
    end
  end

  # 👇 修正ポイント（トークン付きURLはブロックしないようにする）
  def not_authenticated
    if params[:token].present?
      Rails.logger.info ">>> skipping login requirement due to token"
      return
    end
    redirect_to login_path
  end

  # 公開アクションを指定
  def public_action?
    controller_name.in?(%w[top diagnoses]) &&
      action_name.in?(%w[index survey survey_step2 new create show])
  end
end

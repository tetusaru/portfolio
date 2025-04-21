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

  def not_authenticated
    redirect_to login_path
  end

  # 🔓 公開アクションの条件に password_resets を明示追加！
  def public_action?
    controller_name.in?(%w[top diagnoses password_resets]) &&
      action_name.in?(%w[index survey survey_step2 new create show edit update])
  end
end

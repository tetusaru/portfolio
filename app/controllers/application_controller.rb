class ApplicationController < ActionController::Base
  include Sorcery::Controller
  before_action :require_login, unless: :public_action?

  private

  def not_authenticated
    redirect_to login_path
  end

  # 公開アクションを指定
  def public_action?
    controller_name.in?(%w[top diagnoses]) &&
      action_name.in?(%w[index survey survey_step2 new create show])
  end
end

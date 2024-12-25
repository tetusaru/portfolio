class TopController < ApplicationController
  skip_before_action :require_login, only: [ :index, :survey ]

  def index
  end

  def survey
    # アンケートページ用の処理 (必要に応じてデータを渡す)
  end
end

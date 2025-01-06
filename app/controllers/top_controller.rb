class TopController < ApplicationController
  skip_before_action :require_login, only: [ :index, :survey, :survey_step2 ]

  def index
  end

  def survey
    @questions_page1 = [
      { id: 1, text: "熱いサウナが好き？" },
      { id: 2, text: "外気浴でゆっくりしたい？" },
      { id: 3, text: "水風呂は冷たいのが好み？" }
    ]
  end

  def survey_step2
    @questions_page2 = [
      { id: 4, text: "性別は？" },
      { id: 5, text: "どこのサウナを探している？" }
    ]
    @previous_answers = params[:answers] || {}
  end
end

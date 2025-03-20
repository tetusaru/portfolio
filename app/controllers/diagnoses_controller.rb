class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: [ :survey, :answer, :create, :show ]

  def survey
    @questions = [
      { id: 1, text: "お好みのサウナのアツさは？", options: [ "ゲキアツ", "アツい", "普通", "低め" ] },
      { id: 2, text: "外気浴でゆっくりしたい？", options: [ "はい", "いいえ" ] },
      { id: 3, text: "水風呂は冷たいのが好み？", options: [ "はい", "いいえ" ] },
      { id: 4, text: "サウナ施設 or スーパー銭湯", options: [ "サウナ施設", "スーパー銭湯" ] },
      { id: 5, text: "古き良き雰囲気 or 新しく綺麗な感じ", options: [ "古き良き", "新しく綺麗" ] },
      { id: 6, text: "性別を選択してください", options: [ "男性", "女性" ] },
      { id: 7, text: "お住まいの地域を入力してください" }
    ]

    unless params[:question_id].present?
      return redirect_to survey_path(question_id: 1)
    end

    @current_question_id = params[:question_id].to_i
    @current_question = @questions.find { |q| q[:id] == @current_question_id }
  end

  def answer
    session[ :answers ] ||= {}
    session[ :answers ][params[:question_id]] = params[ :answer ]

    next_question_id = params[:question_id].to_i + 1

    if next_question_id <= 7
      redirect_to survey_path(question_id: next_question_id)
    else
      redirect_to survey_finish_path
    end
  end

  def create
    session[ :answers ][params[:question_id]] = params[ :answer ]
    Rails.logger.debug "最終的な受信した回答: #{session[:answers].inspect}"
  
    # 入力チェック：全て空 or location未記入の場合は no_result を返す
    if session[ :answers ].values.all?(&:blank?) || session[ :answers ]["7"].blank?
      redirect_to diagnosis_path(id: 0, no_result: true) and return
    end
  
    facilities = SaunaFacility.all
    facilities = facilities.where(temperature_level: session[:answers]["1"]) if session[:answers]["1"].present?
    facilities = facilities.where(outdoor_bath: true) if session[:answers]["2"] == "yes"
    facilities = facilities.where(cold_bath: true) if session[:answers]["3"] == "yes"
    facilities = facilities.where(facility_type: session[:answers]["4"]) if session[:answers]["4"].present?
    facilities = facilities.where("location LIKE ?", "%#{session[:answers]['5']}%") if session[:answers]["5"].present?
    facilities = facilities.where(atmosphere: session[:answers]["6"]) if session[:answers]["6"].present?
  
    Rails.logger.debug "絞り込まれた施設: #{facilities.map(&:name).inspect}"
    @result = facilities.first
  
    if @result
      redirect_to diagnosis_path(id: @result.id)
    else
      redirect_to diagnosis_path(id: 0, no_result: true)
    end
  end

  def show
    if params[:no_result]
      @result = nil
      @message = "診断結果が見つかりませんでした。もう1度診断してね。"
    else
      @result = SaunaFacility.find(params[:id])
    end
  end
end
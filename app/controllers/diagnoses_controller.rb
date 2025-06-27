class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: [ :survey, :answer, :create, :show ]

  # マッピング定義
  TEMPERATURE_MAP = {
    "ゲキアツ" => "very_hot",
    "アツい" => "hot",
    "普通" => "normal",
    "低め" => "mild"
  }

  FACILITY_TYPE_MAP = {
    "サウナ施設" => "sauna",
    "スーパー銭湯" => "super_sento"
  }

  ATMOSPHERE_MAP = {
    "古き良き" => "classic",
    "新しく綺麗" => "modern"
  }

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
    session[:answers] ||= {}
    session[:answers][params[:question_id]] = params[:answer]

    next_question_id = params[:question_id].to_i + 1

    if next_question_id <= 7
      redirect_to survey_path(question_id: next_question_id)
    else
      redirect_to survey_finish_path
    end
  end

  def create
    session[:answers][params[:question_id]] = params[:answer]
    Rails.logger.debug "最終的な受信した回答: #{session[:answers].inspect}"

    if session[:answers].values.all?(&:blank?) || session[:answers]["7"].blank?
      redirect_to diagnosis_path(id: 0, no_result: true) and return
    end

    # 完全一致で検索
    facilities = SaunaFacility.all
    facilities = facilities.where(temperature_level: TEMPERATURE_MAP[session[:answers]["1"]]) if session[:answers]["1"].present?
    facilities = facilities.where(outdoor_bath: true) if session[:answers]["2"] == "はい"
    facilities = facilities.where(cold_bath: true) if session[:answers]["3"] == "はい"
    facilities = facilities.where(facility_type: FACILITY_TYPE_MAP[session[:answers]["4"]]) if session[:answers]["4"].present?
    facilities = facilities.where("location LIKE ?", "%#{session[:answers]['7']}%") if session[:answers]["7"].present?
    facilities = facilities.where(atmosphere: ATMOSPHERE_MAP[session[:answers]["5"]]) if session[:answers]["5"].present?

    Rails.logger.debug "完全一致で絞り込まれた施設: #{facilities.map(&:name).inspect}"
    @result = facilities.first

    # 完全一致で見つからなかった場合 → 類似候補をスコア付きで検索
    if @result.nil?
      all_facilities = SaunaFacility.where("location LIKE ?", "%#{session[:answers]['7']}%")
      scored = all_facilities.map do |facility|
        score = 0
        score += 1 if session[:answers]["1"].present? && facility.temperature_level == TEMPERATURE_MAP[session[:answers]["1"]]
        score += 1 if session[:answers]["2"] == "はい" && facility.outdoor_bath
        score += 1 if session[:answers]["3"] == "はい" && facility.cold_bath
        score += 1 if session[:answers]["4"].present? && facility.facility_type == FACILITY_TYPE_MAP[session[:answers]["4"]]
        score += 1 if session[:answers]["5"].present? && facility.atmosphere == ATMOSPHERE_MAP[session[:answers]["5"]]
        { facility: facility, score: score }
      end

      # スコアが2点以上の施設のみ対象にする
      filtered = scored.select { |s| s[:score] >= 2 }
      best_match = filtered.max_by { |s| s[:score] }

      @result = best_match[:facility] if best_match
    end

    if @result
      if logged_in?
        diagnosis = current_user.diagnoses.create!
        diagnosis.diagnosis_recommendations.create!(sauna_facility: @result)
      end
      redirect_to sauna_facility_path(@result)
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

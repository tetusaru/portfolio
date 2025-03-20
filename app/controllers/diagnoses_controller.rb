class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: [:survey, :answer, :create, :show]

  def survey
    @questions = [
      { id: 1, text: "熱いサウナが好き？" },
      { id: 2, text: "外気浴でゆっくりしたい？" },
      { id: 3, text: "水風呂は冷たいのが好み？" },
      { id: 4, text: "性別を選択してください", options: ["男性", "女性"] },
      { id: 5, text: "お住まいの地域を選択してください", options: ["東京都", "千葉県", "神奈川県", "埼玉県"] }
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

    if next_question_id <= 5
      redirect_to survey_path(question_id: next_question_id)
    else
      # ここは使われない（最後はcreateに飛ばす）
      redirect_to root_path
    end
  end

  def create
    session[:answers][params[:question_id]] = params[:answer]
    Rails.logger.debug "最終的な受信した回答: #{session[:answers].inspect}"

    facilities = SaunaFacility.all
    facilities = facilities.where(hot_sauna: true) if session[:answers]["1"] == "yes"
    facilities = facilities.where(hot_sauna: false) if session[:answers]["1"] == "no"
    facilities = facilities.where(outdoor_bath: true) if session[:answers]["2"] == "yes"
    facilities = facilities.where(outdoor_bath: false) if session[:answers]["2"] == "no"
    facilities = facilities.where(cold_bath: true) if session[:answers]["3"] == "yes"
    facilities = facilities.where(cold_bath: false) if session[:answers]["3"] == "no"
    facilities = facilities.where("location LIKE ?", "%#{session[:answers]['5']}%") if session[:answers]["5"].present?

    Rails.logger.debug "絞り込まれた施設: #{facilities.map(&:name).inspect}"
    @result = facilities.first

    if @result
      Rails.logger.debug "選択された施設: #{@result.name}"
      redirect_to diagnosis_path(id: @result.id)
    else
      Rails.logger.debug "該当する施設がありません"
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
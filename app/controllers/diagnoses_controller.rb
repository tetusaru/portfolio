class DiagnosesController < ApplicationController
  def create
    Rails.logger.debug "受信した回答: #{params[:answers].inspect}"
  
    # サウナ施設のフィルタリング
    facilities = SaunaFacility.all
    facilities = facilities.where(hot_sauna: true) if params[:answers]["1"] == "yes"
    facilities = facilities.where(hot_sauna: false) if params[:answers]["1"] == "no"
    facilities = facilities.where(outdoor_bath: true) if params[:answers]["2"] == "yes"
    facilities = facilities.where(outdoor_bath: false) if params[:answers]["2"] == "no"
    facilities = facilities.where(cold_bath: true) if params[:answers]["3"] == "yes"
    facilities = facilities.where(cold_bath: false) if params[:answers]["3"] == "no"
    facilities = facilities.where("location LIKE ?", "%#{params[:answers]['5']}%") if params[:answers]["5"].present?
  
    Rails.logger.debug "絞り込まれた施設: #{facilities.map(&:name).inspect}"
    @result = facilities.first
  
    if @result
      Rails.logger.debug "選択された施設: #{@result.name}"
      redirect_to diagnosis_path(id: @result.id)
    else
      Rails.logger.debug "該当する施設がありません"
      redirect_to diagnosis_path(id: 0, no_result: true) # ID 0 と no_result パラメータを渡す
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
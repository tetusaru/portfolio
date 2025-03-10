class SaunaFacilitiesController < ApplicationController
  skip_before_action :require_login, only: [ :show ]

  def index
    @facilities = SaunaFacility.all
  end

  def show
    @facility = SaunaFacility.find(params[:id])

    # 緯度・経度の値をデバッグログに出力
    Rails.logger.debug "Facility ID: #{@facility.id}"
    Rails.logger.debug "Facility Name: #{@facility.name}"
    Rails.logger.debug "Facility Lat/Lng: #{@facility.latitude}, #{@facility.longitude}"
  end
end

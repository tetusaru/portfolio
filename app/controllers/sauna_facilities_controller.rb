class SaunaFacilitiesController < ApplicationController
  def index
    @facilities = SaunaFacility.all
  end

  def show
    @facility = SaunaFacility.find(params[:id])
  end
end

class DiagnosisResultsController < ApplicationController
  def show
    @diagnosis = Diagnosis.find(params[:id])
    @results = @diagnosis.diagnosis_results
  end

  def index
    @sauna_facilities = SaunaFacility.where(location: params[:location])
  end
end

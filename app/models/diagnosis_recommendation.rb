class DiagnosisRecommendation < ApplicationRecord
  belongs_to :diagnosis
  belongs_to :sauna_facility
end

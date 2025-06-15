class Diagnosis < ApplicationRecord
  belongs_to :user, optional: true
  has_many :answers, inverse_of: :diagnosis, dependent: :destroy
  has_many :diagnosis_results, dependent: :destroy
  has_many :diagnosis_recommendations, dependent: :destroy

  accepts_nested_attributes_for :answers
end

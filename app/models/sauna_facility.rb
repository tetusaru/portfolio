class SaunaFacility < ApplicationRecord
  has_many :diagnosis_results, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :hot_sauna, inclusion: { in: [true, false] }
  validates :outdoor_bath, inclusion: { in: [true, false] }
  validates :cold_bath, inclusion: { in: [true, false] }
end

class Mysauna < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user_id, uniqueness: true
end

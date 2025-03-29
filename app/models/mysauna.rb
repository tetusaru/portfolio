class Mysauna < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :posts, dependent: :destroy

  validates :user_id, uniqueness: true
end

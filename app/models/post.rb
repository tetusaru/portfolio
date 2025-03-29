class Post < ApplicationRecord
  belongs_to :user
  belongs_to :mysauna
  has_one_attached :image

  validates :sauna_name, presence: true
  validates :comment, presence: true
end

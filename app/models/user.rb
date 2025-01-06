class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_password
  has_many :answers
  has_many :diagnoses, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password_digest, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
end

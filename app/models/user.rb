class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password_digest, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
end

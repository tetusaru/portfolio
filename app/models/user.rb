class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :answers
  has_many :diagnoses, dependent: :destroy
  has_one :mysauna, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { password.present? } # password_confirmationを確認
end

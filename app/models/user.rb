class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :answers
  has_many :diagnoses, dependent: :destroy
  has_one :mysauna, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 3 }, if: -> { new_record? && crypted_password.present? }
  validates :password, confirmation: true, if: -> { password.present? }

  # テスト用のヘルパーとして追加
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.load_from_remember_me_token(token)
    find_by(remember_me_token: token)
  end
end

require "net/http"
require "json"

class SaunaFacility < ApplicationRecord
  has_many :diagnosis_results, dependent: :destroy
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user

  validates :name, presence: true
  validates :location, presence: true
  validates :hot_sauna, inclusion: { in: [ true, false ] }
  validates :outdoor_bath, inclusion: { in: [ true, false ] }
  validates :cold_bath, inclusion: { in: [ true, false ] }

  before_validation :set_coordinates, if: -> { location_changed? || latitude.blank? || longitude.blank? || latitude == 0.0 || longitude == 0.0 }

  # 既存データの緯度経度を一括更新するメソッド
  def self.update_all_coordinates
    SaunaFacility.find_each do |facility|
      facility.send(:set_coordinates)
      facility.save if facility.latitude.present? && facility.longitude.present?
    end
  end

  protected

  def set_coordinates
    return if location.blank?

    api_key = ENV["GOOGLE_MAPS_API_KEY"]
    return unless api_key.present?

    address = "#{self.location}, Japan"
    url = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode_www_form_component(address)}&key=#{api_key}")

    response = Net::HTTP.get(url)
    json = JSON.parse(response)

    if json["status"] == "OK"
      self.latitude = json["results"][0]["geometry"]["location"]["lat"]
      self.longitude = json["results"][0]["geometry"]["location"]["lng"]
    else
      Rails.logger.error "Google Geocoding API エラー: #{json['status']} (住所: #{address})"
    end
  end
end

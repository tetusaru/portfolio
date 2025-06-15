class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :sauna_facility
end

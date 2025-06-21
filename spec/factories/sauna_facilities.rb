FactoryBot.define do
  factory :sauna_facility do
    name { "テストサウナ" }
    location { "東京都" }
    temperature_level { "very_hot" }
    facility_type { "sauna" }
    atmosphere { "classic" }
    outdoor_bath { true }
    cold_bath { true }
  end
end

class CreateDiagnosisRecommendations < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnosis_recommendations do |t|
      t.references :diagnosis, null: false, foreign_key: true
      t.references :sauna_facility, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateDiagnosisResults < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnosis_results do |t|
      t.references :diagnosis, null: false, foreign_key: true
      t.text :recommendation

      t.timestamps
    end
  end
end

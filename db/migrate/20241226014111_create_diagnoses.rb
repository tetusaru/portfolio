class CreateDiagnoses < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnoses do |t|
      t.references :user, null: false, foreign_key: true
      t.text :questions
      t.string :answers

      t.timestamps
    end
  end
end

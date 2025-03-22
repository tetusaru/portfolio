class CreateMysaunas < ActiveRecord::Migration[8.0]
  def change
    create_table :mysaunas do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :sauna_name
      t.text :comment

      t.timestamps
    end
  end
end

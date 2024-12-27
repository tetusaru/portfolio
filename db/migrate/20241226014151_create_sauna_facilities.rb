class CreateSaunaFacilities < ActiveRecord::Migration[8.0]
  def change
    create_table :sauna_facilities do |t|
      t.string :name
      t.string :location
      t.text :details

      t.timestamps
    end
  end
end

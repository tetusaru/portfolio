class AddAttributesToSaunaFacilities < ActiveRecord::Migration[8.0]
  def change
    add_column :sauna_facilities, :hot_sauna, :boolean, default: false, null: false
    add_column :sauna_facilities, :outdoor_bath, :boolean, default: false, null: false
    add_column :sauna_facilities, :cold_bath, :boolean, default: false, null: false
  end
end

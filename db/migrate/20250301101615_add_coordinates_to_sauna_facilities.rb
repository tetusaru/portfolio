class AddCoordinatesToSaunaFacilities < ActiveRecord::Migration[8.0]
  def change
    add_column :sauna_facilities, :latitude, :float
    add_column :sauna_facilities, :longitude, :float
  end
end

class AddDetailsToSaunaFacilities < ActiveRecord::Migration[8.0]
  def change
    # 温度の詳細レベル（very_hot, hot, normal, mild）
    add_column :sauna_facilities, :temperature_level, :string

    # サウナ施設タイプ（sauna / super_sento）
    add_column :sauna_facilities, :facility_type, :string

    # 雰囲気（classic / modern）
    add_column :sauna_facilities, :atmosphere, :string
  end
end

class ChangeUserIdInDiagnoses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :diagnoses, :user_id, true
  end
end

class AddDiagnosisIdToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_reference :answers, :diagnosis, null: false, foreign_key: true
  end
end

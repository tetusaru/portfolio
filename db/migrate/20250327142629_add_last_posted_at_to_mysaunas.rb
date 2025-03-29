class AddLastPostedAtToMysaunas < ActiveRecord::Migration[8.0]
  def change
    add_column :mysaunas, :last_posted_at, :datetime
  end
end

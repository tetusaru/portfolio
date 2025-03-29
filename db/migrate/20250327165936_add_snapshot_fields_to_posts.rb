class AddSnapshotFieldsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :sauna_name, :string
    add_column :posts, :comment, :text
  end
end

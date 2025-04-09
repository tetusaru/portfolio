class AddRememberMeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :remember_me_token, :string
    add_column :users, :remember_me_token_expires_at, :datetime
  end
end

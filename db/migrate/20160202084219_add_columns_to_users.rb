class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string
    add_column :users, :avatar_url, :string
    add_column :users, :key, :string
    add_column :users, :mastery, :text
  end
end

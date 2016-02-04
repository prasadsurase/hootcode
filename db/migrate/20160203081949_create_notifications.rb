class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, null: false

      t.integer :item_id
      t.string :item_type
      t.string :regarding
      t.boolean :read
      t.integer :count, null: false, default: 0

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end

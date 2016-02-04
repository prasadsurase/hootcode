class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :alerts, :users
  end
end

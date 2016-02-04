class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.references :user, index: true
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :log_entries, :users
  end
end

class CreateLifecycleEvents < ActiveRecord::Migration
  def change
    create_table :lifecycle_events do |t|
      t.references :user, index: true, foreign_key: true
      t.string :key

      t.timestamps null: false
    end
  end
end

class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, index: true

      t.string :key
      t.string :state
      t.string :language
      t.string :slug
      t.text :code
      t.datetime :done_at
      t.boolean :is_liked
      t.integer :nit_count, null: false
      t.integer :version
      t.integer :user_exercise_id
      t.string :filename

      t.timestamps null: false
    end
    add_foreign_key :submissions, :users
  end
end

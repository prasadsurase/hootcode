class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.references :user, index: true, null: false
      t.string    :language
      t.string    :slug
      t.integer   :iteration_count
      t.string    :state
      t.timestamp :completed_at
      t.string    :key

      t.timestamps null: false
    end
    add_foreign_key :user_exercises, :users
  end
end

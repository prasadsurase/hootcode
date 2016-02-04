class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_exercises, :users
  end
end

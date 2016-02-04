class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, null: false
      t.references :submission, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :likes, :users
    add_foreign_key :likes, :submissions
  end
end

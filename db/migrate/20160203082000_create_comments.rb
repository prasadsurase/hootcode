class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false
      t.references :submission, index: true, null: false

      t.text :body
      t.text :html_body

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
  end
end

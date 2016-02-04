class CreateMutedSubmissions < ActiveRecord::Migration
  def change
    create_table :muted_submissions do |t|
      t.references :user, index: true, null: false
      t.references :submission, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :muted_submissions, :users
    add_foreign_key :muted_submissions, :submissions
  end
end

class CreateSubmissionViewers < ActiveRecord::Migration
  def change
    create_table :submission_viewers do |t|
      t.references :submission, index: true, null: false
      
      t.integer :viewer_id, null: false

      t.timestamps null: false
    end
    add_foreign_key :submission_viewers, :submissions
  end
end

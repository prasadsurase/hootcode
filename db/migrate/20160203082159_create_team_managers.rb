class CreateTeamManagers < ActiveRecord::Migration
  def change
    create_table :team_managers do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :team_managers, :users
  end
end

class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.references :user, index: true, null: false
      t.references :team, index: true, null: false
      
      t.boolean :confirmed

      t.timestamps null: false
    end
    add_foreign_key :team_memberships, :users
    add_foreign_key :team_memberships, :teams
  end
end

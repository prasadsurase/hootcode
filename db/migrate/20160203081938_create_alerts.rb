class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :user, index: true
      t.text      :text
      t.string    :url
      t.string    :link_text
      t.boolean   :read


      t.timestamps null: false
    end
    add_foreign_key :alerts, :users
  end
end

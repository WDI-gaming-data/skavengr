class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.integer :owner_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end

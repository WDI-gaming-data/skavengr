class CreateQuestsUsers < ActiveRecord::Migration
  def change
    create_table :quests_users do |t|
      t.references :quest, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

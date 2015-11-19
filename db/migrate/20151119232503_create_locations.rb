class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.text :clue
      t.float :lat
      t.float :lng
      t.references :quest, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

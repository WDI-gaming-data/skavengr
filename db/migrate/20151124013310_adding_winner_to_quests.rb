class AddingWinnerToQuests < ActiveRecord::Migration
  def change
  	add_column :quests, :winner_id, :integer
  end
end

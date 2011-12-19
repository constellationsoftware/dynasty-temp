class RemoveDraftablePlayers < ActiveRecord::Migration
  def up
  	drop_table :draftable_players
  end

  def down
  end
end

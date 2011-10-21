class CreateDraftablePlayers < ActiveRecord::Migration
  def change
    create_table :draftable_players do |t|

      t.timestamps
    end
  end
end

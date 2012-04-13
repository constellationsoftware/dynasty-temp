class AddDepthToDynastyLineups < ActiveRecord::Migration
    def change
        add_column :dynasty_lineups, :string, :integer
        add_index :dynasty_lineups, [ :id, :position_id, :flex, :string ], :name => 'index_dynasty_lineups_on_all'

        Lineup.update_all :string => 1 # all existing lineups are now starters
        lineups = Lineup.order{ id }
        lineups.each do |lineup|
            Lineup.create :position_id => lineup.position_id, :flex => lineup.flex, :string => 2
        end
    end
end

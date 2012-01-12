class AddWaiverToDynastyTeams < ActiveRecord::Migration
    def change
        add_column :dynasty_teams, :waiver_order, :integer
        add_column :dynasty_teams, :draft_order, :integer
    end
end

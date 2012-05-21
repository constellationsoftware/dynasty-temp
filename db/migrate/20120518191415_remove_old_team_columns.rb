class RemoveOldTeamColumns < ActiveRecord::Migration
    def up
        remove_column :dynasty_teams, :is_online
        remove_column :dynasty_teams, :last_socket_id
        remove_column :dynasty_teams, :waiver_order
        remove_column :dynasty_teams, :draft_order
    end

    def down
        add_column :dynasty_teams, :is_online, :boolean
        add_column :dynasty_teams, :last_socket_id, :string
        add_column :dynasty_teams, :waiver_order, :integer
        add_column :dynasty_teams, :draft_order, :integer
    end
end

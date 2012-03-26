class ChangeDynastyClocksToSingleton < ActiveRecord::Migration
    def change
        # remove the clock id from the league and while we're at it, the defunct default balance
        remove_columns :dynasty_leagues, :clock_id, :default_balance_cents

        rename_table :dynasty_clocks, :dynasty_clock # moving to singleton again (i blew it)
        remove_timestamps :dynasty_clock # who cares about these anyway?
    end
end

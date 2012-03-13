class AddClockIdToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :clock_id, :integer
        remove_column :dynasty_leagues, :clock
        add_index :dynasty_leagues, [ :id, :clock_id ]
        rename_table :clocks, :dynasty_clocks

        # Sets all league clocks to the same initial one and reset league sizes
        ActiveRecord::Base.connection.execute("TRUNCATE #{Clock.table_name}")
        clock = Clock.create
        League.all.each do |league|
            league.size = Settings.league.capacity.min
            league.clock_id = clock.id
            league.save
        end
    end

    def down
        remove_column :dynasty_leagues, :clock_id, :integer
        add_column :dynasty_leagues, :clocks, :datetime
        remove_index :dynasty_leagues, [ :id, :clock_id ]
        rename_table :dynasty_clocks, :clock
    end
end

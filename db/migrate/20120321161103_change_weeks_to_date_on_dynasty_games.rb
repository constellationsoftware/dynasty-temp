class ChangeWeeksToDateOnDynastyGames < ActiveRecord::Migration
    def change
        add_column :dynasty_games, :date, :date
        add_index :dynasty_games, [ :id, :league_id, :date ]

        remove_index :dynasty_games, [ :id, :week ]
        remove_column :dynasty_games, :week

        puts 'Truncating games table! You must run "rake dynasty_data_generate_schedules" again.'
        ActiveRecord::Base.connection.execute('TRUNCATE dynasty_games')
        ActiveRecord::Base.connection.execute('TRUNCATE dynasty_accounts')
        Clock.all.each do |clock|
            clock.time = Season.current.start_date.to_time
        end
    end
end

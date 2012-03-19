class CreateDynastySeasons < ActiveRecord::Migration
    def up
        create_table :dynasty_seasons do |t|
            t.string        :affiliation,   :null => false, :limit => 6
            t.integer       :year,          :null => false
            t.integer       :weeks,         :null => false, :default => 0
            t.boolean       :current,       :null => false, :default => 0
            t.date          :start_date,    :null => false
            t.date          :end_date
            t.timestamps
        end

        add_index :dynasty_seasons, [ :affiliation, :current, :weeks ]
        add_index :dynasty_seasons, [ :start_date, :affiliation, :current ]
        add_index :dynasty_seasons, [ :end_date, :affiliation, :current ]

        # fails validation if more than one season for a sport association is set as current
        add_index :dynasty_seasons, [ :affiliation, :year, :current ], :unique => true
    end

    def down
        drop_table :dynasty_seasons
    end
end

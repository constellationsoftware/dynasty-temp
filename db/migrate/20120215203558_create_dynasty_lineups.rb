class CreateDynastyLineups < ActiveRecord::Migration
    def up
        create_table :dynasty_lineups do |t|
            t.integer :position_id
            t.boolean :flex
        end

        add_column :dynasty_player_teams, :lineup_id, :integer

        # position changes
        add_column :dynasty_positions, :flex_position_id, :integer
        change_column :dynasty_positions, :abbreviation, :string, { :limit => 5 }

        flex = Position.new({ :name => 'Offensive Flex', :abbreviation => :flex, :designation => :o, :sort_order => 9 })
        flex.save!
        dflex = Position.new({ :name => 'Defensive Flex', :abbreviation => :dflex, :designation => :d, :sort_order => 10 })
        dflex.save!

        Position.all.each do |position|
            if position.flex === 1
                case position.designation
                when :o
                    position.flex_position_id = flex.id
                when :d
                    position.flex_position_id = dflex.id
                end
                position.save!
            end
        end
        remove_column :dynasty_positions, :flex

        # create initial lineup data
        Lineup.new({ :position_id => Position.find_by_abbreviation('qb').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('rb').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('rb').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('wr').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('wr').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('te').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('flex').id, :flex => true }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('k').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('dl').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('dl').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('lb').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('lb').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('db').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('db').id }).save!
        Lineup.new({ :position_id => Position.find_by_abbreviation('dflex').id, :flex => true }).save!
    end

    def down
        drop_table :dynasty_lineups

        remove_column :dynasty_player_teams, :lineup_id
        remove_column :dynasty_positions, :flex_position_id
        change_column :dynasty_positions, :abbreviation, :string, { :limit => 2 }

        Position.find_by_abbreviation('flex').destroy
        Position.find_by_abbreviation('dflex').destroy

        add_column :dynasty_positions, :flex
    end
end

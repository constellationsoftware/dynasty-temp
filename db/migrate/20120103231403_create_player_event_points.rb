class CreatePlayerEventPoints < ActiveRecord::Migration
  def change
    create_table :dynasty_player_event_points do |t|
      t.integer :player_id                    , :null => false, :default => 0
      t.integer :event_id                     , :null => false, :default => 0
      t.integer :points                       , :null => false, :default => 0
      t.integer :defensive_points             , :null => false, :default => 0
      t.integer :fumbles_points               , :null => false, :default => 0
      t.integer :passing_points               , :null => false, :default => 0
      t.integer :rushing_points               , :null => false, :default => 0
      t.integer :sacks_against_points         , :null => false, :default => 0
      t.integer :scoring_points               , :null => false, :default => 0
      t.integer :special_teams_points         , :null => false, :default => 0

      t.timestamps
    end

    add_index  :dynasty_player_event_points, :player_id
    add_index  :dynasty_player_event_points, :event_id
  end
end

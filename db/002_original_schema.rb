class OriginalDatabaseMigration < ActiveRecord::Migration
  def self.up

ActiveRecord::Schema.define(:version => 2011101384737) do

  create_table :locations do |t|
    t.column :city, :string, :limit => 100
    t.column :state, :string, :limit => 100
    t.column :area, :string, :limit => 100
    t.column :country, :string, :limit => 100
    t.column :timezone, :string, :limit => 100
    t.column :latitude, :string, :limit => 100
    t.column :longitude, :string, :limit => 100
    t.column :country_code, :string, :limit => 100
  end
  add_index(:locations, [:country_code], :name => :IDX_locations_1)

  create_table :addresses do |t|
    t.references :locations
    t.column :language, :string, :limit => 100
    t.column :suite, :string, :limit => 100
    t.column :floor, :string, :limit => 100
    t.column :building, :string, :limit => 100
    t.column :street_number, :string, :limit => 100
    t.column :street_prefix, :string, :limit => 100
    t.column :street, :string, :limit => 100
    t.column :street_suffix, :string, :limit => 100
    t.column :neighborhood, :string, :limit => 100
    t.column :district, :string, :limit => 100
    t.column :locality, :string, :limit => 100
    t.column :county, :string, :limit => 100
    t.column :region, :string, :limit => 100
    t.column :postal_code, :string, :limit => 100
    t.column :country, :string, :limit => 100
  end
  add_index(:addresses, [:locality], :name => :IDX_addresses_1)
  add_index(:addresses, [:id], :name => :IDX_addresses_2)
  add_index(:addresses, [:postal_code], :name => :IDX_addresses_3)
  add_index(:addresses, [:location_id], :name => :IDX_FK_add_loc_id__loc_id)

  create_table :publishers do |t|
    t.column :publisher_key, :string, :limit => 100, :null => false
    t.column :publisher_name, :string, :limit => 100
  end
  add_index(:publishers, [:publisher_key], :name => :IDX_publishers_1)

  create_table :affiliations do |t|
    t.column :affiliation_key, :string, :limit => 100, :null => false
    t.column :affiliation_type, :string, :limit => 100
    t.references :publishers
  end
  add_index(:affiliations, [:affiliation_key], :name => :IDX_affiliations_1)
  add_index(:affiliations, [:affiliation_type], :name => :IDX_affiliations_2)
  add_index(:affiliations, [:affiliation_key, :affiliation_type, :publisher_id], :name => :IDX_affiliations_3)
  add_index(:affiliations, [:publisher_id], :name => :IDX_FK_aff_pub_id__pub_id)

  create_table :seasons do |t|
    t.column :season_key, :integer, :null => false
    t.references :publishers
    t.references :affiliations
    t.column :start_date_time, :timestamp
    t.column :end_date_time, :timestamp
  end
  add_index(:seasons, [:league_id], :name => :IDX_FK_sea_lea_id__aff_id)
  add_index(:seasons, [:publisher_id], :name => :IDX_FK_sea_pub_id__pub_id)
  add_index(:seasons, [:season_key], :name => :IDX_seasons_1)

  create_table :affiliation_phases do |t|
    t.references :affiliations
    t.column :root_id, :integer
    t.references :affiliations
    t.references :seasons
    t.column :start_date_time, :timestamp
    t.references :seasons
    t.column :end_date_time, :timestamp
  end

  create_table :sites do |t|
    t.column :site_key, :string, :limit => 128, :null => false
    t.references :publishers
    t.references :locations
  end
  add_index(:sites, [:location_id], :name => :IDX_FK_sit_loc_id__loc_id)
  add_index(:sites, [:publisher_id], :name => :IDX_FK_sit_pub_id__pub_id)
  add_index(:sites, [:site_key], :name => :IDX_sites_1)

  create_table :events do |t|
    t.column :event_key, :string, :limit => 100, :null => false
    t.references :publishers
    t.column :start_date_time, :timestamp
    t.references :sites
    t.column :site_alignment, :string, :limit => 100
    t.column :event_status, :string, :limit => 100
    t.column :duration, :string, :limit => 100
    t.column :attendance, :string, :limit => 100
    t.column :last_update, :timestamp
    t.column :event_number, :string, :limit => 32
    t.column :round_number, :string, :limit => 32
    t.column :time_certainty, :string, :limit => 100
    t.column :broadcast_listing, :string, :limit => 255
    t.column :start_date_time_local, :timestamp
    t.column :medal_event, :string, :limit => 100
    t.column :series_index, :string, :limit => 40
  end
  add_index(:events, [:event_key], :name => :IDX_events_1)
  add_index(:events, [:publisher_id], :name => :IDX_FK_eve_pub_id__pub_id)
  add_index(:events, [:site_id], :name => :IDX_FK_eve_sit_id__sit_id)

  create_table :affiliations_events, :id => false do |t|
    t.references :affiliations
    t.references :events
  end

  create_table :persons do |t|
    t.column :person_key, :string, :limit => 100, :null => false
    t.references :publishers
    t.column :gender, :string, :limit => 20
    t.column :birth_date, :string, :limit => 30
    t.column :death_date, :string, :limit => 30
    t.references :locations
    t.references :locations
    t.references :locations
    t.references :locations
    t.references :locations
  end
  add_index(:persons, [:publisher_id], :name => :IDX_FK_per_pub_id__pub_id)
  add_index(:persons, [:person_key], :name => :IDX_persons_1)

  create_table :media do |t|
    t.column :object_id, :integer
    t.column :source_id, :integer
    t.column :revision_id, :integer
    t.column :media_type, :string, :limit => 100
    t.references :publishers
    t.column :date_time, :string, :limit => 100
    t.references :persons
    t.column :db_loading_date_time, :timestamp
    t.references :locations
  end

  create_table :affiliations_media, :id => false do |t|
    t.references :affiliations
    t.references :media
  end

  create_table :teams do |t|
    t.column :team_key, :string, :limit => 100, :null => false
    t.references :publishers
    t.references :sites
  end
  add_index(:teams, [:team_key], :name => :IDX_teams_team_key)

  create_table :american_football_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :period_value, :integer
    t.column :period_time_elapsed, :string, :limit => 100
    t.column :period_time_remaining, :string, :limit => 100
    t.column :clock_state, :string, :limit => 100
    t.column :down, :integer
    t.references :teams
    t.column :score_team, :integer
    t.column :score_team_opposing, :integer
    t.column :distance_for_1st_down, :integer
    t.column :field_side, :string, :limit => 100
    t.column :field_line, :integer
    t.column :context, :string, :limit => 40
    t.column :score_team_away, :integer
    t.column :score_team_home, :integer
    t.column :document_id, :integer
  end
  add_index(:american_football_event_states, [:current_state], :name => :IDX_american_football_event_states_1)
  add_index(:american_football_event_states, [:context], :name => :IDX_american_football_event_states_context)
  add_index(:american_football_event_states, [:sequence_number], :name => :IDX_american_football_event_states_seq_num)
  add_index(:american_football_event_states, [:event_id], :name => :IDX_FK_ame_foo_eve_sta_eve_id__eve_id)

  create_table :american_football_action_plays do |t|
    t.references :american_football_event_states
    t.references :teams
    t.column :play_type, :string, :limit => 100
    t.column :score_attempt_type, :string, :limit => 100
    t.column :touchdown_type, :string, :limit => 100
    t.column :drive_result, :string, :limit => 100
    t.column :points, :integer
    t.column :comment, :string, :limit => 512
  end
  add_index(:american_football_action_plays, [:play_type], :name => :IDX_american_football_action_plays_1)
  add_index(:american_football_action_plays, [:score_attempt_type], :name => :IDX_american_football_action_plays_2)
  add_index(:american_football_action_plays, [:drive_result], :name => :IDX_american_football_action_plays_3)
  add_index(:american_football_action_plays, [:american_football_event_state_id], :name => :IDX_FK_ame_foo_act_pla_ame_foo_eve_sta_id__ame_foo_eve_sta_id)

  create_table :american_football_action_participants do |t|
    t.references :american_football_action_plays
    t.references :persons
    t.column :participant_role, :string, :limit => 100, :null => false
    t.column :score_type, :string, :limit => 100
    t.column :field_line, :integer
    t.column :yardage, :integer
    t.column :score_credit, :integer
    t.column :yards_gained, :integer
  end
  add_index(:american_football_action_participants, [:participant_role], :name => :IDX_american_football_action_participants_1)
  add_index(:american_football_action_participants, [:score_type], :name => :IDX_american_football_action_participants_2)
  add_index(:american_football_action_participants, [:american_football_action_play_id], :name => :IDX_FK_ame_foo_act_par_ame_foo_act_pla_id__ame_foo_act_pla_id)
  add_index(:american_football_action_participants, [:person_id], :name => :IDX_FK_ame_foo_act_par_per_id__per_id)

  create_table :american_football_defensive_stats do |t|
    t.column :tackles_total, :string, :limit => 100
    t.column :tackles_solo, :string, :limit => 100
    t.column :tackles_assists, :string, :limit => 100
    t.column :interceptions_total, :string, :limit => 100
    t.column :interceptions_yards, :string, :limit => 100
    t.column :interceptions_average, :string, :limit => 100
    t.column :interceptions_longest, :string, :limit => 100
    t.column :interceptions_touchdown, :string, :limit => 100
    t.column :quarterback_hurries, :string, :limit => 100
    t.column :sacks_total, :string, :limit => 100
    t.column :sacks_yards, :string, :limit => 100
    t.column :passes_defensed, :string, :limit => 100
    t.column :first_downs_against_total, :integer
    t.column :first_downs_against_rushing, :integer
    t.column :first_downs_against_passing, :integer
    t.column :first_downs_against_penalty, :integer
    t.column :conversions_third_down_against, :integer
    t.column :conversions_third_down_against_attempts, :integer
    t.column :conversions_third_down_against_percentage, :string, :limit => 5 , 2
    t.column :conversions_fourth_down_against, :integer
    t.column :conversions_fourth_down_against_attempts, :integer
    t.column :conversions_fourth_down_against_percentage, :string, :limit => 5 , 2
    t.column :two_point_conversions_against, :integer
    t.column :two_point_conversions_against_attempts, :integer
    t.column :offensive_plays_against_touchdown, :integer
    t.column :offensive_plays_against_average_yards_per_game, :string, :limit => 5 , 2
    t.column :rushes_against_attempts, :integer
    t.column :rushes_against_yards, :integer
    t.column :rushing_against_average_yards_per_game, :string, :limit => 5 , 2
    t.column :rushes_against_touchdowns, :integer
    t.column :rushes_against_average_yards_per, :string, :limit => 5 , 2
    t.column :rushes_against_longest, :integer
    t.column :receptions_against_total, :integer
    t.column :receptions_against_yards, :integer
    t.column :receptions_against_touchdowns, :integer
    t.column :receptions_against_average_yards_per, :string, :limit => 5 , 2
    t.column :receptions_against_longest, :integer
    t.column :passes_against_yards_net, :integer
    t.column :passes_against_yards_gross, :integer
    t.column :passes_against_attempts, :integer
    t.column :passes_against_completions, :integer
    t.column :passes_against_percentage, :string, :limit => 5 , 2
    t.column :passes_against_average_yards_per_game, :string, :limit => 5 , 2
    t.column :passes_against_average_yards_per, :string, :limit => 5 , 2
    t.column :passes_against_touchdowns, :integer
    t.column :passes_against_touchdowns_percentage, :string, :limit => 5 , 2
    t.column :passes_against_longest, :integer
    t.column :passes_against_rating, :string, :limit => 5 , 2
    t.column :interceptions_percentage, :string, :limit => 5 , 2
  end

  create_table :american_football_down_progress_stats do |t|
    t.column :first_downs_total, :string, :limit => 100
    t.column :first_downs_pass, :string, :limit => 100
    t.column :first_downs_run, :string, :limit => 100
    t.column :first_downs_penalty, :string, :limit => 100
    t.column :conversions_third_down, :string, :limit => 100
    t.column :conversions_third_down_attempts, :string, :limit => 100
    t.column :conversions_third_down_percentage, :string, :limit => 100
    t.column :conversions_fourth_down, :string, :limit => 100
    t.column :conversions_fourth_down_attempts, :string, :limit => 100
    t.column :conversions_fourth_down_percentage, :string, :limit => 100
  end

  create_table :american_football_fumbles_stats do |t|
    t.column :fumbles_committed, :string, :limit => 100
    t.column :fumbles_forced, :string, :limit => 100
    t.column :fumbles_recovered, :string, :limit => 100
    t.column :fumbles_lost, :string, :limit => 100
    t.column :fumbles_yards_gained, :string, :limit => 100
    t.column :fumbles_own_committed, :string, :limit => 100
    t.column :fumbles_own_recovered, :string, :limit => 100
    t.column :fumbles_own_lost, :string, :limit => 100
    t.column :fumbles_own_yards_gained, :string, :limit => 100
    t.column :fumbles_opposing_committed, :string, :limit => 100
    t.column :fumbles_opposing_recovered, :string, :limit => 100
    t.column :fumbles_opposing_lost, :string, :limit => 100
    t.column :fumbles_opposing_yards_gained, :string, :limit => 100
    t.column :fumbles_own_touchdowns, :integer
    t.column :fumbles_opposing_touchdowns, :integer
    t.column :fumbles_committed_defense, :integer
    t.column :fumbles_committed_special_teams, :integer
    t.column :fumbles_committed_other, :integer
    t.column :fumbles_lost_defense, :integer
    t.column :fumbles_lost_special_teams, :integer
    t.column :fumbles_lost_other, :integer
    t.column :fumbles_forced_defense, :integer
    t.column :fumbles_recovered_defense, :integer
    t.column :fumbles_recovered_special_teams, :integer
    t.column :fumbles_recovered_other, :integer
    t.column :fumbles_recovered_yards_defense, :integer
    t.column :fumbles_recovered_yards_special_teams, :integer
    t.column :fumbles_recovered_yards_other, :integer
  end

  create_table :american_football_offensive_stats do |t|
    t.column :offensive_plays_yards, :string, :limit => 100
    t.column :offensive_plays_number, :string, :limit => 100
    t.column :offensive_plays_average_yards_per, :string, :limit => 100
    t.column :possession_duration, :string, :limit => 100
    t.column :turnovers_giveaway, :string, :limit => 100
    t.column :tackles, :integer
    t.column :tackles_assists, :integer
  end

  create_table :american_football_passing_stats do |t|
    t.column :passes_attempts, :string, :limit => 100
    t.column :passes_completions, :string, :limit => 100
    t.column :passes_percentage, :string, :limit => 100
    t.column :passes_yards_gross, :string, :limit => 100
    t.column :passes_yards_net, :string, :limit => 100
    t.column :passes_yards_lost, :string, :limit => 100
    t.column :passes_touchdowns, :string, :limit => 100
    t.column :passes_touchdowns_percentage, :string, :limit => 100
    t.column :passes_interceptions, :string, :limit => 100
    t.column :passes_interceptions_percentage, :string, :limit => 100
    t.column :passes_longest, :string, :limit => 100
    t.column :passes_average_yards_per, :string, :limit => 100
    t.column :passer_rating, :string, :limit => 100
    t.column :receptions_total, :string, :limit => 100
    t.column :receptions_yards, :string, :limit => 100
    t.column :receptions_touchdowns, :string, :limit => 100
    t.column :receptions_first_down, :string, :limit => 100
    t.column :receptions_longest, :string, :limit => 100
    t.column :receptions_average_yards_per, :string, :limit => 100
  end

  create_table :american_football_penalties_stats do |t|
    t.column :penalties_total, :string, :limit => 100
    t.column :penalty_yards, :string, :limit => 100
    t.column :penalty_first_downs, :string, :limit => 100
  end

  create_table :american_football_rushing_stats do |t|
    t.column :rushes_attempts, :string, :limit => 100
    t.column :rushes_yards, :string, :limit => 100
    t.column :rushes_touchdowns, :string, :limit => 100
    t.column :rushing_average_yards_per, :string, :limit => 100
    t.column :rushes_first_down, :string, :limit => 100
    t.column :rushes_longest, :string, :limit => 100
  end

  create_table :american_football_sacks_against_stats do |t|
    t.column :sacks_against_yards, :string, :limit => 100
    t.column :sacks_against_total, :string, :limit => 100
  end

  create_table :american_football_scoring_stats do |t|
    t.column :touchdowns_total, :string, :limit => 100
    t.column :touchdowns_passing, :string, :limit => 100
    t.column :touchdowns_rushing, :string, :limit => 100
    t.column :touchdowns_special_teams, :string, :limit => 100
    t.column :touchdowns_defensive, :string, :limit => 100
    t.column :extra_points_attempts, :string, :limit => 100
    t.column :extra_points_made, :string, :limit => 100
    t.column :extra_points_missed, :string, :limit => 100
    t.column :extra_points_blocked, :string, :limit => 100
    t.column :field_goal_attempts, :string, :limit => 100
    t.column :field_goals_made, :string, :limit => 100
    t.column :field_goals_missed, :string, :limit => 100
    t.column :field_goals_blocked, :string, :limit => 100
    t.column :safeties_against, :string, :limit => 100
    t.column :two_point_conversions_attempts, :string, :limit => 100
    t.column :two_point_conversions_made, :string, :limit => 100
    t.column :touchbacks_total, :string, :limit => 100
    t.column :safeties_against_opponent, :integer
  end

  create_table :american_football_special_teams_stats do |t|
    t.column :returns_punt_total, :string, :limit => 100
    t.column :returns_punt_yards, :string, :limit => 100
    t.column :returns_punt_average, :string, :limit => 100
    t.column :returns_punt_longest, :string, :limit => 100
    t.column :returns_punt_touchdown, :string, :limit => 100
    t.column :returns_kickoff_total, :string, :limit => 100
    t.column :returns_kickoff_yards, :string, :limit => 100
    t.column :returns_kickoff_average, :string, :limit => 100
    t.column :returns_kickoff_longest, :string, :limit => 100
    t.column :returns_kickoff_touchdown, :string, :limit => 100
    t.column :returns_total, :string, :limit => 100
    t.column :returns_yards, :string, :limit => 100
    t.column :punts_total, :string, :limit => 100
    t.column :punts_yards_gross, :string, :limit => 100
    t.column :punts_yards_net, :string, :limit => 100
    t.column :punts_longest, :string, :limit => 100
    t.column :punts_inside_20, :string, :limit => 100
    t.column :punts_inside_20_percentage, :string, :limit => 100
    t.column :punts_average, :string, :limit => 100
    t.column :punts_blocked, :string, :limit => 100
    t.column :touchbacks_total, :string, :limit => 100
    t.column :touchbacks_total_percentage, :string, :limit => 100
    t.column :touchbacks_kickoffs, :string, :limit => 100
    t.column :touchbacks_kickoffs_percentage, :string, :limit => 100
    t.column :touchbacks_punts, :string, :limit => 100
    t.column :touchbacks_punts_percentage, :string, :limit => 100
    t.column :touchbacks_interceptions, :string, :limit => 100
    t.column :touchbacks_interceptions_percentage, :string, :limit => 100
    t.column :fair_catches, :string, :limit => 100
    t.column :punts_against_blocked, :integer
    t.column :field_goals_against_attempts_1_to_19, :integer
    t.column :field_goals_against_made_1_to_19, :integer
    t.column :field_goals_against_attempts_20_to_29, :integer
    t.column :field_goals_against_made_20_to_29, :integer
    t.column :field_goals_against_attempts_30_to_39, :integer
    t.column :field_goals_against_made_30_to_39, :integer
    t.column :field_goals_against_attempts_40_to_49, :integer
    t.column :field_goals_against_made_40_to_49, :integer
    t.column :field_goals_against_attempts_50_plus, :integer
    t.column :field_goals_against_made_50_plus, :integer
    t.column :field_goals_against_attempts, :integer
    t.column :extra_points_against_attempts, :integer
    t.column :tackles, :integer
    t.column :tackles_assists, :integer
  end

  create_table :american_football_team_stats do |t|
    t.column :yards_per_attempt, :string, :limit => 100
    t.column :average_starting_position, :string, :limit => 100
    t.column :timeouts, :string, :limit => 100
    t.column :time_of_possession, :string, :limit => 100
    t.column :turnover_ratio, :string, :limit => 100
  end

  create_table :awards do |t|
    t.column :participant_type, :string, :limit => 100, :null => false
    t.column :participant_id, :integer, :null => false
    t.column :award_type, :string, :limit => 100
    t.column :name, :string, :limit => 100
    t.column :total, :integer
    t.column :rank, :string, :limit => 100
    t.column :award_value, :string, :limit => 100
    t.column :currency, :string, :limit => 100
    t.column :date_coverage_type, :string, :limit => 100
    t.column :date_coverage_id, :integer
  end

  create_table :baseball_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :string, :limit => 4 , 1
    t.column :at_bat_number, :integer
    t.column :inning_value, :integer
    t.column :inning_half, :string, :limit => 100
    t.column :outs, :integer
    t.column :balls, :integer
    t.column :strikes, :integer
    t.references :persons
    t.references :persons
    t.references :persons
    t.column :runner_on_first, :integer
    t.column :runner_on_second, :integer
    t.column :runner_on_third, :integer
    t.column :runs_this_inning_half, :integer
    t.references :persons
    t.references :persons
    t.column :batter_side, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:baseball_event_states, [:current_state], :name => :IDX_baseball_event_states_1)
  add_index(:baseball_event_states, [:context], :name => :IDX_baseball_event_states_context)
  add_index(:baseball_event_states, [:sequence_number], :name => :IDX_baseball_event_states_seq_num)
  add_index(:baseball_event_states, [:event_id], :name => :IDX_FK_bas_eve_sta_eve_id__eve_id)

  create_table :baseball_action_plays do |t|
    t.references :baseball_event_states
    t.column :play_type, :string, :limit => 100
    t.column :out_type, :string, :limit => 100
    t.column :notation, :string, :limit => 100
    t.column :notation_yaml, :text
    t.column :baseball_defensive_group_id, :integer
    t.column :comment, :string, :limit => 512
    t.column :runner_on_first_advance, :string, :limit => 40
    t.column :runner_on_second_advance, :string, :limit => 40
    t.column :runner_on_third_advance, :string, :limit => 40
    t.column :outs_recorded, :integer
    t.column :rbi, :integer
    t.column :runs_scored, :integer
    t.column :earned_runs_scored, :string, :limit => 100
  end
  add_index(:baseball_action_plays, [:play_type], :name => :IDX_baseball_action_plays_1)
  add_index(:baseball_action_plays, [:out_type], :name => :IDX_baseball_action_plays_2)
  add_index(:baseball_action_plays, [:baseball_event_state_id], :name => :IDX_FK_bas_act_pla_bas_eve_sta_id__bas_eve_sta_id)

  create_table :baseball_defensive_group do |t|
  end

  create_table :baseball_action_pitches do |t|
    t.references :baseball_action_plays
    t.column :sequence_number, :string, :limit => 4 , 1
    t.references :baseball_defensive_group
    t.column :umpire_call, :string, :limit => 100
    t.column :pitch_location, :string, :limit => 100
    t.column :pitch_type, :string, :limit => 100
    t.column :pitch_velocity, :integer
    t.column :comment, :string, :limit => 2048
    t.column :trajectory_coordinates, :string, :limit => 512
    t.column :trajectory_formula, :string, :limit => 100
    t.column :ball_type, :string, :limit => 40
    t.column :strike_type, :string, :limit => 40
    t.column :strikes, :integer
    t.column :balls, :integer
  end
  add_index(:baseball_action_pitches, [:umpire_call], :name => :IDX_baseball_action_pitches_1)
  add_index(:baseball_action_pitches, [:pitch_type], :name => :IDX_baseball_action_pitches_2)
  add_index(:baseball_action_pitches, [:baseball_defensive_group_id], :name => :IDX_FK_bas_act_pit_bas_def_gro_id__bas_def_gro_id)

  create_table :baseball_action_contact_details do |t|
    t.references :baseball_action_pitches
    t.column :location, :string, :limit => 100
    t.column :strength, :string, :limit => 100
    t.column :velocity, :integer
    t.column :comment, :string, :limit => 512
    t.column :trajectory_coordinates, :string, :limit => 100
    t.column :trajectory_formula, :string, :limit => 100
  end

  create_table :positions do |t|
    t.references :affiliations
    t.column :abbreviation, :string, :limit => 100, :null => false
  end
  add_index(:positions, [:affiliation_id], :name => :IDX_FK_pos_aff_id__aff_id)
  add_index(:positions, [:abbreviation], :name => :IDX_positions_1)

  create_table :baseball_action_substitutions do |t|
    t.references :baseball_event_states
    t.column :sequence_number, :string, :limit => 4 , 1
    t.column :person_type, :string, :limit => 100
    t.references :persons
    t.references :positions
    t.column :person_original_lineup_slot, :integer
    t.references :persons
    t.references :positions
    t.column :person_replacing_lineup_slot, :integer
    t.column :substitution_reason, :string, :limit => 100
    t.column :comment, :string, :limit => 512
  end

  create_table :baseball_defensive_players do |t|
    t.references :baseball_defensive_group
    t.references :persons
    t.references :positions
  end

  create_table :baseball_defensive_stats do |t|
    t.column :double_plays, :integer
    t.column :triple_plays, :integer
    t.column :putouts, :integer
    t.column :assists, :integer
    t.column :errors, :integer
    t.column :fielding_percentage, :string
    t.column :defensive_average, :string
    t.column :errors_passed_ball, :integer
    t.column :errors_catchers_interference, :integer
    t.column :stolen_bases_average, :integer
    t.column :stolen_bases_caught, :integer
  end

  create_table :baseball_offensive_stats do |t|
    t.column :average, :string
    t.column :runs_scored, :integer
    t.column :at_bats, :integer
    t.column :hits, :integer
    t.column :rbi, :integer
    t.column :total_bases, :integer
    t.column :slugging_percentage, :string
    t.column :bases_on_balls, :integer
    t.column :strikeouts, :integer
    t.column :left_on_base, :integer
    t.column :left_in_scoring_position, :integer
    t.column :singles, :integer
    t.column :doubles, :integer
    t.column :triples, :integer
    t.column :home_runs, :integer
    t.column :grand_slams, :integer
    t.column :at_bats_per_rbi, :string
    t.column :plate_appearances_per_rbi, :string
    t.column :at_bats_per_home_run, :string
    t.column :plate_appearances_per_home_run, :string
    t.column :sac_flies, :integer
    t.column :sac_bunts, :integer
    t.column :grounded_into_double_play, :integer
    t.column :moved_up, :integer
    t.column :on_base_percentage, :string
    t.column :stolen_bases, :integer
    t.column :stolen_bases_caught, :integer
    t.column :stolen_bases_average, :string
    t.column :hit_by_pitch, :integer
    t.column :on_base_plus_slugging, :string
    t.column :plate_appearances, :integer
    t.column :hits_extra_base, :integer
    t.column :pick_offs_against, :integer
    t.column :sacrifices, :integer
    t.column :outs_fly, :integer
    t.column :outs_ground, :integer
    t.column :reached_base_defensive_interference, :integer
    t.column :reached_base_error, :integer
    t.column :reached_base_fielder_choice, :integer
    t.column :double_plays_against, :integer
    t.column :triple_plays_against, :integer
    t.column :strikeouts_looking, :integer
    t.column :bases_on_balls_intentional, :integer
  end

  create_table :baseball_pitching_stats do |t|
    t.column :runs_allowed, :integer
    t.column :singles_allowed, :integer
    t.column :doubles_allowed, :integer
    t.column :triples_allowed, :integer
    t.column :home_runs_allowed, :integer
    t.column :innings_pitched, :string, :limit => 20
    t.column :hits, :integer
    t.column :earned_runs, :integer
    t.column :unearned_runs, :integer
    t.column :bases_on_balls, :integer
    t.column :bases_on_balls_intentional, :integer
    t.column :strikeouts, :integer
    t.column :strikeout_to_bb_ratio, :string
    t.column :number_of_pitches, :integer
    t.column :era, :string
    t.column :inherited_runners_scored, :integer
    t.column :pick_offs, :integer
    t.column :errors_hit_with_pitch, :integer
    t.column :errors_wild_pitch, :integer
    t.column :balks, :integer
    t.column :wins, :integer
    t.column :losses, :integer
    t.column :saves, :integer
    t.column :shutouts, :integer
    t.column :games_complete, :integer
    t.column :games_finished, :integer
    t.column :winning_percentage, :string
    t.column :event_credit, :string, :limit => 40
    t.column :save_credit, :string, :limit => 40
    t.column :batters_doubles_against, :integer
    t.column :batters_triples_against, :integer
    t.column :outs_recorded, :integer
    t.column :batters_at_bats_against, :integer
    t.column :number_of_strikes, :integer
    t.column :wins_season, :integer
    t.column :losses_season, :integer
    t.column :saves_season, :integer
    t.column :saves_blown_season, :integer
  end

  create_table :basketball_defensive_stats do |t|
    t.column :steals_total, :string, :limit => 100
    t.column :steals_per_game, :string, :limit => 100
    t.column :blocks_total, :string, :limit => 100
    t.column :blocks_per_game, :string, :limit => 100
  end

  create_table :basketball_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :period_value, :string, :limit => 100
    t.column :period_time_elapsed, :string, :limit => 100
    t.column :period_time_remaining, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:basketball_event_states, [:context], :name => :IDX_basketball_event_states_context)
  add_index(:basketball_event_states, [:sequence_number], :name => :IDX_basketball_event_states_seq_num)
  add_index(:basketball_event_states, [:event_id], :name => :IDX_FK_events_basketball_event_states)

  create_table :basketball_offensive_stats do |t|
    t.column :field_goals_made, :integer
    t.column :field_goals_attempted, :integer
    t.column :field_goals_percentage, :string, :limit => 100
    t.column :field_goals_per_game, :string, :limit => 100
    t.column :field_goals_attempted_per_game, :string, :limit => 100
    t.column :field_goals_percentage_adjusted, :string, :limit => 100
    t.column :three_pointers_made, :integer
    t.column :three_pointers_attempted, :integer
    t.column :three_pointers_percentage, :string, :limit => 100
    t.column :three_pointers_per_game, :string, :limit => 100
    t.column :three_pointers_attempted_per_game, :string, :limit => 100
    t.column :free_throws_made, :string, :limit => 100
    t.column :free_throws_attempted, :string, :limit => 100
    t.column :free_throws_percentage, :string, :limit => 100
    t.column :free_throws_per_game, :string, :limit => 100
    t.column :free_throws_attempted_per_game, :string, :limit => 100
    t.column :points_scored_total, :string, :limit => 100
    t.column :points_scored_per_game, :string, :limit => 100
    t.column :assists_total, :string, :limit => 100
    t.column :assists_per_game, :string, :limit => 100
    t.column :turnovers_total, :string, :limit => 100
    t.column :turnovers_per_game, :string, :limit => 100
    t.column :points_scored_off_turnovers, :string, :limit => 100
    t.column :points_scored_in_paint, :string, :limit => 100
    t.column :points_scored_on_second_chance, :string, :limit => 100
    t.column :points_scored_on_fast_break, :string, :limit => 100
  end

  create_table :basketball_rebounding_stats do |t|
    t.column :rebounds_total, :string, :limit => 100
    t.column :rebounds_per_game, :string, :limit => 100
    t.column :rebounds_defensive, :string, :limit => 100
    t.column :rebounds_offensive, :string, :limit => 100
    t.column :team_rebounds_total, :string, :limit => 100
    t.column :team_rebounds_per_game, :string, :limit => 100
    t.column :team_rebounds_defensive, :string, :limit => 100
    t.column :team_rebounds_offensive, :string, :limit => 100
  end

  create_table :basketball_team_stats do |t|
    t.column :timeouts_left, :string, :limit => 100
    t.column :largest_lead, :string, :limit => 100
    t.column :fouls_total, :string, :limit => 100
    t.column :turnover_margin, :string, :limit => 100
  end

  create_table :bookmakers do |t|
    t.column :bookmaker_key, :string, :limit => 100
    t.references :publishers
    t.references :locations
  end

  create_table :core_stats do |t|
    t.column :score, :string, :limit => 100
    t.column :score_opposing, :string, :limit => 100
    t.column :score_attempts, :string, :limit => 100
    t.column :score_attempts_opposing, :string, :limit => 100
    t.column :score_percentage, :string, :limit => 100
    t.column :score_percentage_opposing, :string, :limit => 100
    t.column :time_played_event, :string, :limit => 40
    t.column :time_played_total, :string, :limit => 40
    t.column :time_played_event_average, :string, :limit => 40
    t.column :events_played, :string, :limit => 40
    t.column :events_started, :string, :limit => 40
    t.column :position_id, :integer
  end

  create_table :db_info, :id => false do |t|
    t.column :version, :string, :limit => 100, :default => '16', :null => false
  end
  add_index(:db_info, [:version], :name => :IDX_db_info_1)

  create_table :display_names do |t|
    t.column :language, :string, :limit => 100, :null => false
    t.column :entity_type, :string, :limit => 100, :null => false
    t.column :entity_id, :integer, :null => false
    t.column :full_name, :string, :limit => 100
    t.column :first_name, :string, :limit => 100
    t.column :middle_name, :string, :limit => 100
    t.column :last_name, :string, :limit => 100
    t.column :alias, :string, :limit => 100
    t.column :abbreviation, :string, :limit => 100
    t.column :short_name, :string, :limit => 100
    t.column :prefix, :string, :limit => 20
    t.column :suffix, :string, :limit => 20
  end
  add_index(:display_names, [:entity_id], :name => :IDX_display_names_1)
  add_index(:display_names, [:entity_type], :name => :IDX_display_names_2)

  create_table :document_classes do |t|
    t.column :name, :string, :limit => 100
  end
  add_index(:document_classes, [:name], :name => :IDX_document_classes_1)

  create_table :document_fixtures do |t|
    t.column :fixture_key, :string, :limit => 100
    t.references :publishers
    t.column :name, :string, :limit => 100
    t.references :document_classes
  end
  add_index(:document_fixtures, [:fixture_key], :name => :IDX_document_fixtures_1)
  add_index(:document_fixtures, [:document_class_id], :name => :IDX_FK_doc_fix_doc_cla_id__doc_cla_id)
  add_index(:document_fixtures, [:publisher_id], :name => :IDX_FK_doc_fix_pub_id__pub_id)

  create_table :documents do |t|
    t.column :doc_id, :string, :limit => 75, :null => false
    t.references :publishers
    t.column :date_time, :timestamp
    t.column :title, :string, :limit => 255
    t.column :language, :string, :limit => 100
    t.column :priority, :string, :limit => 100
    t.column :revision_id, :string, :limit => 255
    t.column :stats_coverage, :string, :limit => 100
    t.references :document_fixtures
    t.references :publishers
    t.column :db_loading_date_time, :timestamp
  end
  add_index(:documents, [:doc_id], :name => :IDX_documents_1)
  add_index(:documents, [:date_time], :name => :IDX_documents_3)
  add_index(:documents, [:priority], :name => :IDX_documents_4)
  add_index(:documents, [:revision_id], :name => :IDX_documents_5)
  add_index(:documents, [:document_fixture_id], :name => :IDX_FK_doc_doc_fix_id__doc_fix_id)
  add_index(:documents, [:publisher_id], :name => :IDX_FK_doc_pub_id__pub_id)
  add_index(:documents, [:source_id], :name => :IDX_FK_doc_sou_id__pub_id)

  create_table :affiliations_documents, :id => false do |t|
    t.references :affiliations
    t.references :documents
  end

  create_table :document_contents do |t|
    t.references :documents
    t.column :sportsml, :string, :limit => 200
    t.column :sportsml_blob, :text
    t.column :abstract, :text
    t.column :abstract_blob, :text
  end
  add_index(:document_contents, [:document_id], :name => :IDX_FK_doc_con_doc_id__doc_id)

  create_table :document_fixtures_events do |t|
    t.references :document_fixtures
    t.references :events
    t.references :documents
    t.column :last_update, :timestamp
  end
  add_index(:document_fixtures_events, [:document_fixture_id], :name => :IDX_FK_doc_fix_eve_doc_fix_id__doc_fix_id)
  add_index(:document_fixtures_events, [:event_id], :name => :IDX_FK_doc_fix_eve_eve_id__eve_id)
  add_index(:document_fixtures_events, [:latest_document_id], :name => :IDX_FK_doc_fix_eve_lat_doc_id__doc_id)

  create_table :document_packages do |t|
    t.column :package_key, :string, :limit => 100
    t.column :package_name, :string, :limit => 100
    t.column :date_time, :date
  end

  create_table :document_package_entry do |t|
    t.references :document_packages
    t.column :rank, :string, :limit => 100
    t.references :documents
    t.column :headline, :string, :limit => 100
    t.column :short_headline, :string, :limit => 100
  end

  create_table :media_captions do |t|
    t.references :media
    t.column :caption_type, :string, :limit => 100
    t.column :caption, :string, :limit => 100
    t.references :persons
    t.column :language, :string, :limit => 100
    t.column :caption_size, :string, :limit => 100
  end

  create_table :documents_media do |t|
    t.references :documents
    t.references :media
    t.references :media_captions
  end

  create_table :event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :period_value, :string, :limit => 100
    t.column :period_time_elapsed, :string, :limit => 100
    t.column :period_time_remaining, :string, :limit => 100
    t.column :minutes_elapsed, :string, :limit => 100
    t.column :period_minutes_elapsed, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:event_states, [:context], :name => :IDX_event_states_context)
  add_index(:event_states, [:sequence_number], :name => :IDX_event_states_seq_num)

  create_table :event_action_fouls do |t|
    t.references :event_states
    t.column :foul_name, :string, :limit => 100
    t.column :foul_result, :string, :limit => 100
    t.column :foul_type, :string, :limit => 100
    t.column :fouler_id, :string, :limit => 100
    t.column :recipient_type, :string, :limit => 100
    t.column :recipient_id, :integer
    t.column :comment, :string, :limit => 512
  end

  create_table :event_action_plays do |t|
    t.references :event_states
    t.column :play_type, :string, :limit => 100
    t.column :score_attempt_type, :string, :limit => 100
    t.column :play_result, :string, :limit => 100
    t.column :comment, :string, :limit => 512
  end

  create_table :event_action_participants do |t|
    t.references :event_states
    t.references :event_action_plays
    t.references :persons
    t.column :participant_role, :string, :limit => 100
  end

  create_table :event_action_penalties do |t|
    t.references :event_states
    t.column :penalty_type, :string, :limit => 100
    t.column :penalty_level, :string, :limit => 100
    t.column :caution_level, :string, :limit => 100
    t.column :recipient_type, :string, :limit => 100
    t.column :recipient_id, :integer
    t.column :comment, :string, :limit => 512
  end

  create_table :event_action_substitutions do |t|
    t.references :event_states
    t.references :persons
    t.references :positions
    t.references :persons
    t.references :positions
    t.column :substitution_reason, :string, :limit => 100
    t.column :comment, :string, :limit => 512
  end

  create_table :events_documents, :id => false do |t|
    t.references :events
    t.references :documents
  end

  create_table :events_media, :id => false do |t|
    t.references :events
    t.references :media
  end

  create_table :sub_seasons do |t|
    t.column :sub_season_key, :string, :limit => 100, :null => false
    t.references :seasons
    t.column :sub_season_type, :string, :limit => 100, :null => false
    t.column :start_date_time, :timestamp
    t.column :end_date_time, :timestamp
  end
  add_index(:sub_seasons, [:season_id], :name => :IDX_FK_sub_sea_sea_id__sea_id)
  add_index(:sub_seasons, [:sub_season_key], :name => :IDX_sub_seasons_1)
  add_index(:sub_seasons, [:sub_season_type], :name => :IDX_sub_seasons_2)

  create_table :events_sub_seasons, :id => false do |t|
    t.references :events
    t.references :sub_seasons
  end

  create_table :ice_hockey_event_states do |t|
    t.references :teams
    t.references :events
    t.column :current_state, :integer
    t.column :period_value, :string, :limit => 100
    t.column :period_time_elapsed, :string, :limit => 100
    t.column :period_time_remaining, :string, :limit => 100
    t.column :record_type, :string, :limit => 40
    t.column :power_play_player_advantage, :integer
    t.column :score_team, :integer
    t.column :score_team_opposing, :integer
    t.column :score_team_home, :integer
    t.column :score_team_away, :integer
    t.column :action_key, :string, :limit => 100
    t.column :sequence_number, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:ice_hockey_event_states, [:context], :name => :IDX_ice_hockey_event_states_context)
  add_index(:ice_hockey_event_states, [:sequence_number], :name => :IDX_ice_hockey_event_states_seq_num)

  create_table :ice_hockey_action_participants do |t|
    t.references :teams
    t.column :ice_hockey_action_play_id, :integer, :null => false
    t.references :persons
    t.column :participant_role, :string, :limit => 100
    t.column :point_credit, :integer
    t.column :goals_cumulative, :integer
    t.column :assists_cumulative, :integer
  end

  create_table :ice_hockey_defensive_stats do |t|
    t.column :goals_power_play_allowed, :string, :limit => 100
    t.column :goals_penalty_shot_allowed, :string, :limit => 100
    t.column :goals_empty_net_allowed, :string, :limit => 100
    t.column :goals_against_average, :string, :limit => 100
    t.column :goals_short_handed_allowed, :string, :limit => 100
    t.column :goals_shootout_allowed, :string, :limit => 100
    t.column :shots_power_play_allowed, :string, :limit => 100
    t.column :shots_penalty_shot_allowed, :string, :limit => 100
    t.column :shots_blocked, :string, :limit => 100
    t.column :saves, :string, :limit => 100
    t.column :save_percentage, :string, :limit => 100
    t.column :penalty_killing_amount, :string, :limit => 100
    t.column :penalty_killing_percentage, :string, :limit => 100
    t.column :takeaways, :string, :limit => 100
    t.column :shutouts, :string, :limit => 100
    t.column :minutes_penalty_killing, :string, :limit => 100
    t.column :hits, :string, :limit => 100
    t.column :shots_shootout_allowed, :string, :limit => 100
    t.column :goaltender_wins, :integer
    t.column :goaltender_losses, :integer
    t.column :goaltender_ties, :integer
    t.column :goals_allowed, :integer
    t.column :shots_allowed, :integer
    t.column :player_count, :integer
    t.column :player_count_opposing, :integer
    t.column :goaltender_wins_overtime, :integer
    t.column :goaltender_losses_overtime, :integer
    t.column :goals_overtime_allowed, :integer
  end

  create_table :ice_hockey_faceoff_stats do |t|
    t.column :player_count, :integer
    t.column :player_count_opposing, :integer
    t.column :faceoff_wins, :integer
    t.column :faceoff_losses, :integer
    t.column :faceoff_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_power_play_wins, :integer
    t.column :faceoffs_power_play_losses, :integer
    t.column :faceoffs_power_play_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_short_handed_wins, :integer
    t.column :faceoffs_short_handed_losses, :integer
    t.column :faceoffs_short_handed_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_even_strength_wins, :integer
    t.column :faceoffs_even_strength_losses, :integer
    t.column :faceoffs_even_strength_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_offensive_zone_wins, :integer
    t.column :faceoffs_offensive_zone_losses, :integer
    t.column :faceoffs_offensive_zone_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_defensive_zone_wins, :integer
    t.column :faceoffs_defensive_zone_losses, :integer
    t.column :faceoffs_defensive_zone_win_percentage, :string, :limit => 5 , 2
    t.column :faceoffs_neutral_zone_wins, :integer
    t.column :faceoffs_neutral_zone_losses, :integer
    t.column :faceoffs_neutral_zone_win_percentage, :string, :limit => 5 , 2
  end

  create_table :ice_hockey_offensive_stats do |t|
    t.column :giveaways, :string, :limit => 100
    t.column :goals, :integer
    t.column :goals_game_winning, :string, :limit => 100
    t.column :goals_game_tying, :string, :limit => 100
    t.column :goals_power_play, :string, :limit => 100
    t.column :goals_short_handed, :string, :limit => 100
    t.column :goals_even_strength, :string, :limit => 100
    t.column :goals_empty_net, :string, :limit => 100
    t.column :goals_overtime, :string, :limit => 100
    t.column :goals_shootout, :string, :limit => 100
    t.column :goals_penalty_shot, :string, :limit => 100
    t.column :assists, :string, :limit => 100
    t.column :shots, :integer
    t.column :shots_penalty_shot_taken, :string, :limit => 100
    t.column :shots_penalty_shot_missed, :string, :limit => 100
    t.column :shots_penalty_shot_percentage, :string, :limit => 100
    t.column :shots_missed, :integer
    t.column :shots_blocked, :integer
    t.column :shots_power_play, :integer
    t.column :shots_short_handed, :integer
    t.column :shots_even_strength, :integer
    t.column :points, :string, :limit => 100
    t.column :power_play_amount, :string, :limit => 100
    t.column :power_play_percentage, :string, :limit => 100
    t.column :minutes_power_play, :string, :limit => 100
    t.column :faceoff_wins, :string, :limit => 100
    t.column :faceoff_losses, :string, :limit => 100
    t.column :faceoff_win_percentage, :string, :limit => 100
    t.column :scoring_chances, :string, :limit => 100
    t.column :player_count, :integer
    t.column :player_count_opposing, :integer
    t.column :assists_game_winning, :integer
    t.column :assists_overtime, :integer
  end

  create_table :ice_hockey_player_stats do |t|
    t.column :plus_minus, :string, :limit => 100
  end

  create_table :ice_hockey_time_on_ice_stats do |t|
    t.column :player_count, :integer
    t.column :player_count_opposing, :integer
    t.column :shifts, :integer
    t.column :time_total, :string, :limit => 40
    t.column :time_power_play, :string, :limit => 40
    t.column :time_short_handed, :string, :limit => 40
    t.column :time_even_strength, :string, :limit => 40
    t.column :time_empty_net, :string, :limit => 40
    t.column :time_power_play_empty_net, :string, :limit => 40
    t.column :time_short_handed_empty_net, :string, :limit => 40
    t.column :time_even_strength_empty_net, :string, :limit => 40
    t.column :time_average_per_shift, :string, :limit => 40
  end

  create_table :injury_phases do |t|
    t.references :persons
    t.column :injury_status, :string, :limit => 100
    t.column :injury_type, :string, :limit => 100
    t.column :injury_comment, :string, :limit => 100
    t.column :disabled_list, :string, :limit => 100
    t.column :start_date_time, :timestamp
    t.column :end_date_time, :timestamp
    t.references :seasons
    t.column :phase_type, :string, :limit => 100
    t.column :injury_side, :string, :limit => 100
  end
  add_index(:injury_phases, [:person_id], :name => :IDX_FK_inj_pha_per_id__per_id)
  add_index(:injury_phases, [:season_id], :name => :IDX_FK_inj_pha_sea_id__sea_id)
  add_index(:injury_phases, [:injury_status], :name => :IDX_injury_phases_2)
  add_index(:injury_phases, [:start_date_time], :name => :IDX_injury_phases_3)
  add_index(:injury_phases, [:end_date_time], :name => :IDX_injury_phases_4)

  create_table :key_roots do |t|
    t.column :key_type, :string, :limit => 100
  end
  add_index(:key_roots, [:key_type], :name => :IDX_key_aliases_1)

  create_table :key_aliases do |t|
    t.column :key_id, :integer, :null => false
    t.references :key_roots
  end
  add_index(:key_aliases, [:key_id], :name => :IDX_key_aliases_2)

  create_table :latest_revisions do |t|
    t.column :revision_id, :string, :limit => 255, :null => false
    t.references :documents
  end
  add_index(:latest_revisions, [:latest_document_id], :name => :IDX_FK_lat_rev_lat_doc_id__doc_id)
  add_index(:latest_revisions, [:revision_id], :name => :IDX_latest_revisions_1)

  create_table :media_contents do |t|
    t.references :media
    t.column :object, :string, :limit => 100
    t.column :format, :string, :limit => 100
    t.column :mime_type, :string, :limit => 100
    t.column :height, :string, :limit => 100
    t.column :width, :string, :limit => 100
    t.column :duration, :string, :limit => 100
    t.column :file_size, :string, :limit => 100
    t.column :resolution, :string, :limit => 100
  end

  create_table :media_keywords do |t|
    t.column :keyword, :string, :limit => 100
    t.references :media
  end

  create_table :motor_racing_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :lap, :string, :limit => 100
    t.column :laps_remaining, :string, :limit => 100
    t.column :time_elapsed, :string, :limit => 100
    t.column :flag_state, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:motor_racing_event_states, [:event_id], :name => :IDX_FK_events_motor_racing_event_states)
  add_index(:motor_racing_event_states, [:context], :name => :IDX_motor_racing_event_states_context)
  add_index(:motor_racing_event_states, [:sequence_number], :name => :IDX_motor_racing_event_states_seq_num)

  create_table :motor_racing_event_stats do |t|
    t.column :speed_average, :string, :limit => 6 , 3
    t.column :speed_units, :string, :limit => 40
    t.column :margin_of_victory, :string, :limit => 6 , 3
    t.column :caution_flags, :integer
    t.column :caution_flags_laps, :integer
    t.column :lead_changes, :integer
    t.column :lead_changes_drivers, :integer
    t.column :laps_total, :integer
  end

  create_table :motor_racing_qualifying_stats do |t|
    t.column :grid, :string, :limit => 100
    t.column :pole_position, :string, :limit => 100
    t.column :pole_wins, :string, :limit => 100
    t.column :qualifying_speed, :string, :limit => 100
    t.column :qualifying_speed_units, :string, :limit => 100
    t.column :qualifying_time, :string, :limit => 100
    t.column :qualifying_position, :string, :limit => 100
  end

  create_table :motor_racing_race_stats do |t|
    t.column :time_behind_leader, :string, :limit => 100
    t.column :laps_behind_leader, :string, :limit => 100
    t.column :time_ahead_follower, :string, :limit => 100
    t.column :laps_ahead_follower, :string, :limit => 100
    t.column :time, :string, :limit => 100
    t.column :points, :string, :limit => 100
    t.column :points_rookie, :string, :limit => 100
    t.column :bonus, :string, :limit => 100
    t.column :laps_completed, :string, :limit => 100
    t.column :laps_leading_total, :string, :limit => 100
    t.column :distance_leading, :string, :limit => 100
    t.column :distance_completed, :string, :limit => 100
    t.column :distance_units, :string, :limit => 40
    t.column :speed_average, :string, :limit => 40
    t.column :speed_units, :string, :limit => 40
    t.column :status, :string, :limit => 40
    t.column :finishes_top_5, :string, :limit => 40
    t.column :finishes_top_10, :string, :limit => 40
    t.column :starts, :string, :limit => 40
    t.column :finishes, :string, :limit => 40
    t.column :non_finishes, :string, :limit => 40
    t.column :wins, :string, :limit => 40
    t.column :races_leading, :string, :limit => 40
    t.column :money, :string, :limit => 40
    t.column :money_units, :string, :limit => 40
    t.column :leads_total, :string, :limit => 40
  end

  create_table :standings do |t|
    t.references :affiliations
    t.column :standing_type, :string, :limit => 100
    t.references :sub_seasons
    t.column :last_updated, :string, :limit => 100
    t.column :source, :string, :limit => 100
  end

  create_table :standing_subgroups do |t|
    t.references :standings
    t.references :affiliations
    t.column :alignment_scope, :string, :limit => 100
    t.column :competition_scope, :string, :limit => 100
    t.column :competition_scope_id, :string, :limit => 100
    t.column :duration_scope, :string, :limit => 100
    t.column :scoping_label, :string, :limit => 100
    t.column :site_scope, :string, :limit => 100
  end

  create_table :outcome_totals do |t|
    t.references :standing_subgroups
    t.column :outcome_holder_type, :string, :limit => 100
    t.column :outcome_holder_id, :integer
    t.column :rank, :string, :limit => 100
    t.column :wins, :string, :limit => 100
    t.column :losses, :string, :limit => 100
    t.column :ties, :string, :limit => 100
    t.column :wins_overtime, :integer
    t.column :losses_overtime, :integer
    t.column :undecideds, :string, :limit => 100
    t.column :winning_percentage, :string, :limit => 100
    t.column :points_scored_for, :string, :limit => 100
    t.column :points_scored_against, :string, :limit => 100
    t.column :points_difference, :string, :limit => 100
    t.column :standing_points, :string, :limit => 100
    t.column :streak_type, :string, :limit => 100
    t.column :streak_duration, :string, :limit => 100
    t.column :streak_total, :string, :limit => 100
    t.column :streak_start, :timestamp
    t.column :streak_end, :timestamp
    t.column :events_played, :integer
    t.column :games_back, :string, :limit => 100
    t.column :result_effect, :string, :limit => 100
    t.column :sets_against, :string, :limit => 100
    t.column :sets_for, :string, :limit => 100
  end

  create_table :participants_events do |t|
    t.column :participant_type, :string, :limit => 100, :null => false
    t.column :participant_id, :integer, :null => false
    t.references :events
    t.column :alignment, :string, :limit => 100
    t.column :score, :string, :limit => 100
    t.column :event_outcome, :string, :limit => 100
    t.column :rank, :integer
    t.column :result_effect, :string, :limit => 100
    t.column :score_attempts, :integer
    t.column :sort_order, :string, :limit => 100
    t.column :score_type, :string, :limit => 100
  end
  add_index(:participants_events, [:event_id], :name => :IDX_FK_par_eve_eve_id__eve_id)
  add_index(:participants_events, [:participant_type], :name => :IDX_participants_events_1)
  add_index(:participants_events, [:participant_id], :name => :IDX_participants_events_2)
  add_index(:participants_events, [:alignment], :name => :IDX_participants_events_3)
  add_index(:participants_events, [:event_outcome], :name => :IDX_participants_events_4)

  create_table :penalty_stats do |t|
    t.column :count, :integer
    t.column :type, :string, :limit => 100
    t.column :value, :integer
  end

  create_table :periods do |t|
    t.references :participants_events
    t.column :period_value, :string, :limit => 100
    t.column :score, :string, :limit => 100
    t.column :score_attempts, :integer
    t.column :rank, :string, :limit => 100
    t.column :sub_score_key, :string, :limit => 100
    t.column :sub_score_type, :string, :limit => 100
    t.column :sub_score_name, :string, :limit => 100
  end
  add_index(:periods, [:participant_event_id], :name => :IDX_FK_per_par_eve_id__par_eve_id)

  create_table :roles do |t|
    t.column :role_key, :string, :limit => 100, :null => false
    t.column :role_name, :string, :limit => 100
    t.column :comment, :string, :limit => 100
  end
  add_index(:roles, [:role_key], :name => :IDX_roles_1)

  create_table :person_event_metadata do |t|
    t.references :persons
    t.references :events
    t.column :status, :string, :limit => 100
    t.column :health, :string, :limit => 100
    t.column :weight, :string, :limit => 100
    t.references :roles
    t.references :positions
    t.references :teams
    t.column :lineup_slot, :integer
    t.column :lineup_slot_sequence, :integer
  end
  add_index(:person_event_metadata, [:event_id], :name => :IDX_FK_per_eve_met_eve_id__eve_id)
  add_index(:person_event_metadata, [:person_id], :name => :IDX_FK_per_eve_met_per_id__per_id)
  add_index(:person_event_metadata, [:position_id], :name => :IDX_FK_per_eve_met_pos_id__pos_id)
  add_index(:person_event_metadata, [:role_id], :name => :IDX_FK_per_eve_met_rol_id__rol_id)
  add_index(:person_event_metadata, [:team_id], :name => :IDX_FK_teams_person_event_metadata)
  add_index(:person_event_metadata, [:status], :name => :IDX_person_event_metadata_1)

  create_table :person_phases do |t|
    t.references :persons
    t.column :membership_type, :string, :limit => 40, :null => false
    t.column :membership_id, :integer, :null => false
    t.references :roles
    t.column :role_status, :string, :limit => 40
    t.column :phase_status, :string, :limit => 40
    t.column :uniform_number, :string, :limit => 20
    t.references :positions
    t.column :regular_position_depth, :string, :limit => 40
    t.column :height, :string, :limit => 100
    t.column :weight, :string, :limit => 100
    t.column :start_date_time, :timestamp
    t.references :seasons
    t.column :end_date_time, :timestamp
    t.references :seasons
    t.column :entry_reason, :string, :limit => 40
    t.column :exit_reason, :string, :limit => 40
    t.column :selection_level, :integer
    t.column :selection_sublevel, :integer
    t.column :selection_overall, :integer
    t.column :duration, :string, :limit => 32
    t.column :phase_type, :string, :limit => 40
    t.column :subphase_type, :string, :limit => 40
  end
  add_index(:person_phases, [:person_id], :name => :IDX_FK_per_pha_per_id__per_id)
  add_index(:person_phases, [:regular_position_id], :name => :IDX_FK_per_pha_reg_pos_id__pos_id)
  add_index(:person_phases, [:membership_type], :name => :IDX_person_phases_1)
  add_index(:person_phases, [:membership_id], :name => :IDX_person_phases_2)
  add_index(:person_phases, [:phase_status], :name => :IDX_person_phases_3)

  create_table :persons_documents, :id => false do |t|
    t.references :persons
    t.references :documents
  end

  create_table :persons_media, :id => false do |t|
    t.references :persons
    t.references :media
  end

  create_table :rankings do |t|
    t.column :document_fixture_id, :integer
    t.column :participant_type, :string, :limit => 100
    t.column :participant_id, :integer
    t.column :issuer, :string, :limit => 100
    t.column :ranking_type, :string, :limit => 100
    t.column :ranking_value, :string, :limit => 100
    t.column :ranking_value_previous, :string, :limit => 100
    t.column :date_coverage_type, :string, :limit => 100
    t.column :date_coverage_id, :integer
  end

  create_table :records do |t|
    t.column :participant_type, :string, :limit => 100
    t.column :participant_id, :integer
    t.column :record_type, :string, :limit => 100
    t.column :record_label, :string, :limit => 100
    t.column :record_value, :string, :limit => 100
    t.column :previous_value, :string, :limit => 100
    t.column :date_coverage_type, :string, :limit => 100
    t.column :date_coverage_id, :integer
    t.column :comment, :string, :limit => 512
  end

  create_table :soccer_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :period_value, :string, :limit => 100
    t.column :period_time_elapsed, :string, :limit => 100
    t.column :period_time_remaining, :string, :limit => 100
    t.column :minutes_elapsed, :string, :limit => 100
    t.column :period_minute_elapsed, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:soccer_event_states, [:event_id], :name => :IDX_FK_events_soccer_event_states)
  add_index(:soccer_event_states, [:context], :name => :IDX_soccer_event_states_context)
  add_index(:soccer_event_states, [:sequence_number], :name => :IDX_soccer_event_states_seq_num)

  create_table :soccer_action_fouls do |t|
    t.references :soccer_event_states
    t.column :foul_name, :string, :limit => 100
    t.column :foul_result, :string, :limit => 100
    t.column :foul_type, :string, :limit => 100
    t.column :fouler_id, :string, :limit => 100
    t.column :recipient_type, :string, :limit => 100
    t.references :persons
    t.column :comment, :string, :limit => 512
  end

  create_table :soccer_action_plays do |t|
    t.references :soccer_event_states
    t.column :play_type, :string, :limit => 100
    t.column :score_attempt_type, :string, :limit => 100
    t.column :play_result, :string, :limit => 100
    t.column :comment, :string, :limit => 100
  end

  create_table :soccer_action_participants do |t|
    t.references :soccer_action_plays
    t.references :persons
    t.column :participant_role, :string, :limit => 100
  end

  create_table :soccer_action_penalties do |t|
    t.references :soccer_event_states
    t.column :penalty_type, :string, :limit => 100
    t.column :penalty_level, :string, :limit => 100
    t.column :caution_value, :string, :limit => 100
    t.column :recipient_type, :string, :limit => 100
    t.references :persons
    t.column :comment, :string, :limit => 512
  end

  create_table :soccer_action_substitutions do |t|
    t.references :soccer_event_states
    t.column :person_type, :string, :limit => 100
    t.references :persons
    t.references :positions
    t.references :persons
    t.references :positions
    t.column :substitution_reason, :string, :limit => 100
    t.column :comment, :string, :limit => 512
  end

  create_table :soccer_defensive_stats do |t|
    t.column :shots_penalty_shot_allowed, :string, :limit => 100
    t.column :goals_penalty_shot_allowed, :string, :limit => 100
    t.column :goals_against_average, :string, :limit => 100
    t.column :goals_against_total, :string, :limit => 100
    t.column :saves, :string, :limit => 100
    t.column :save_percentage, :string, :limit => 100
    t.column :catches_punches, :string, :limit => 100
    t.column :shots_on_goal_total, :string, :limit => 100
    t.column :shots_shootout_total, :string, :limit => 100
    t.column :shots_shootout_allowed, :string, :limit => 100
    t.column :shots_blocked, :string, :limit => 100
    t.column :shutouts, :string, :limit => 100
  end

  create_table :soccer_foul_stats do |t|
    t.column :fouls_suffered, :string, :limit => 100
    t.column :fouls_commited, :string, :limit => 100
    t.column :cautions_total, :string, :limit => 100
    t.column :cautions_pending, :string, :limit => 100
    t.column :caution_points_total, :string, :limit => 100
    t.column :caution_points_pending, :string, :limit => 100
    t.column :ejections_total, :string, :limit => 100
  end

  create_table :soccer_offensive_stats do |t|
    t.column :goals_game_winning, :string, :limit => 100
    t.column :goals_game_tying, :string, :limit => 100
    t.column :goals_overtime, :string, :limit => 100
    t.column :goals_shootout, :string, :limit => 100
    t.column :goals_total, :string, :limit => 100
    t.column :assists_game_winning, :string, :limit => 100
    t.column :assists_game_tying, :string, :limit => 100
    t.column :assists_overtime, :string, :limit => 100
    t.column :assists_total, :string, :limit => 100
    t.column :points, :string, :limit => 100
    t.column :shots_total, :string, :limit => 100
    t.column :shots_on_goal_total, :string, :limit => 100
    t.column :shots_hit_frame, :string, :limit => 100
    t.column :shots_penalty_shot_taken, :string, :limit => 100
    t.column :shots_penalty_shot_scored, :string, :limit => 100
    t.column :shots_penalty_shot_missed, :string, :limit => 40
    t.column :shots_penalty_shot_percentage, :string, :limit => 40
    t.column :shots_shootout_taken, :string, :limit => 40
    t.column :shots_shootout_scored, :string, :limit => 40
    t.column :shots_shootout_missed, :string, :limit => 40
    t.column :shots_shootout_percentage, :string, :limit => 40
    t.column :giveaways, :string, :limit => 40
    t.column :offsides, :string, :limit => 40
    t.column :corner_kicks, :string, :limit => 40
    t.column :hat_tricks, :string, :limit => 40
  end

  create_table :sports_property do |t|
    t.column :sports_property_type, :string, :limit => 100
    t.column :sports_property_id, :integer
    t.column :formal_name, :string, :limit => 100, :null => false
    t.column :value, :string, :limit => 255
  end

  create_table :stats do |t|
    t.column :stat_repository_type, :string, :limit => 100
    t.column :stat_repository_id, :integer, :null => false
    t.column :stat_holder_type, :string, :limit => 100
    t.column :stat_holder_id, :integer
    t.column :stat_coverage_type, :string, :limit => 100
    t.column :stat_coverage_id, :integer
    t.column :stat_membership_type, :string, :limit => 40
    t.column :stat_membership_id, :integer
    t.column :context, :string, :limit => 40, :null => false
  end
  add_index(:stats, [:stat_repository_type], :name => :IDX_stats_1)
  add_index(:stats, [:stat_repository_id], :name => :IDX_stats_2)
  add_index(:stats, [:stat_holder_type], :name => :IDX_stats_3)
  add_index(:stats, [:stat_holder_id], :name => :IDX_stats_4)
  add_index(:stats, [:stat_coverage_type], :name => :IDX_stats_5)
  add_index(:stats, [:stat_coverage_id], :name => :IDX_stats_6)
  add_index(:stats, [:context], :name => :IDX_stats_7)

  create_table :sub_periods do |t|
    t.references :periods
    t.column :sub_period_value, :string, :limit => 100
    t.column :score, :string, :limit => 100
    t.column :score_attempts, :integer
  end
  add_index(:sub_periods, [:period_id], :name => :IDX_FK_sub_per_per_id__per_id)

  create_table :team_phases do |t|
    t.references :teams
    t.references :seasons
    t.references :seasons
    t.references :affiliations
    t.column :start_date_time, :string, :limit => 100
    t.column :end_date_time, :string, :limit => 100
    t.column :phase_status, :string, :limit => 40
    t.references :roles
  end

  create_table :teams_documents, :id => false do |t|
    t.references :teams
    t.references :documents
  end

  create_table :teams_media, :id => false do |t|
    t.references :teams
    t.references :media
  end

  create_table :tennis_action_points do |t|
    t.column :sub_period_id, :string, :limit => 100
    t.column :sequence_number, :string, :limit => 100
    t.column :win_type, :string, :limit => 100
  end

  create_table :tennis_action_volleys do |t|
    t.column :sequence_number, :string, :limit => 100
    t.column :tennis_action_points_id, :integer
    t.column :landing_location, :string, :limit => 100
    t.column :swing_type, :string, :limit => 100
    t.column :result, :string, :limit => 100
    t.column :spin_type, :string, :limit => 100
    t.column :trajectory_details, :string, :limit => 100
  end

  create_table :tennis_event_states do |t|
    t.references :events
    t.column :current_state, :integer
    t.column :sequence_number, :integer
    t.column :tennis_set, :string, :limit => 100
    t.column :game, :string, :limit => 100
    t.column :server_person_id, :integer
    t.column :server_score, :string, :limit => 100
    t.column :receiver_person_id, :integer
    t.column :receiver_score, :string, :limit => 100
    t.column :service_number, :string, :limit => 100
    t.column :context, :string, :limit => 40
    t.column :document_id, :integer
  end
  add_index(:tennis_event_states, [:event_id], :name => :IDX_FK_events_tennis_event_states)
  add_index(:tennis_event_states, [:context], :name => :IDX_tennis_event_states_context)
  add_index(:tennis_event_states, [:sequence_number], :name => :IDX_tennis_event_states_seq_num)

  create_table :tennis_player_stats do |t|
    t.column :net_points_won, :integer
    t.column :net_points_played, :integer
    t.column :points_won, :integer
    t.column :winners, :integer
    t.column :unforced_errors, :integer
    t.column :winners_forehand, :integer
    t.column :winners_backhand, :integer
    t.column :winners_volley, :integer
  end

  create_table :tennis_return_stats do |t|
    t.column :returns_played, :integer
    t.column :matches_played, :integer
    t.column :first_service_return_points_won, :integer
    t.column :first_service_return_points_won_pct, :integer
    t.column :second_service_return_points_won, :integer
    t.column :second_service_return_points_won_pct, :integer
    t.column :return_games_played, :integer
    t.column :return_games_won, :integer
    t.column :return_games_won_pct, :integer
    t.column :break_points_played, :integer
    t.column :break_points_converted, :integer
    t.column :break_points_converted_pct, :integer
    t.column :net_points_won, :integer
    t.column :net_points_played, :integer
    t.column :points_won, :integer
    t.column :winners, :integer
    t.column :unforced_errors, :integer
    t.column :winners_forehand, :integer
    t.column :winners_backhand, :integer
    t.column :winners_volley, :integer
  end

  create_table :tennis_service_stats do |t|
    t.column :services_played, :integer
    t.column :matches_played, :integer
    t.column :aces, :integer
    t.column :first_services_good, :integer
    t.column :first_services_good_pct, :integer
    t.column :first_service_points_won, :integer
    t.column :first_service_points_won_pct, :integer
    t.column :second_service_points_won, :integer
    t.column :second_service_points_won_pct, :integer
    t.column :service_games_played, :integer
    t.column :service_games_won, :integer
    t.column :service_games_won_pct, :integer
    t.column :break_points_played, :integer
    t.column :break_points_saved, :integer
    t.column :break_points_saved_pct, :integer
    t.column :service_points_won, :integer
    t.column :service_points_won_pct, :integer
    t.column :double_faults, :integer
    t.column :first_service_top_speed, :string, :limit => 100
    t.column :second_services_good, :integer
    t.column :second_services_good_pct, :integer
    t.column :second_service_top_speed, :string, :limit => 100
    t.column :net_points_won, :integer
    t.column :net_points_played, :integer
    t.column :points_won, :integer
    t.column :winners, :integer
    t.column :unforced_errors, :integer
    t.column :winners_forehand, :integer
    t.column :winners_backhand, :integer
    t.column :winners_volley, :integer
  end

  create_table :tennis_set_stats do |t|
    t.column :net_points_won, :integer
    t.column :net_points_played, :integer
    t.column :points_won, :integer
    t.column :winners, :integer
    t.column :unforced_errors, :integer
    t.column :winners_forehand, :integer
    t.column :winners_backhand, :integer
    t.column :winners_volley, :integer
  end

  create_table :tennis_team_stats do |t|
    t.column :net_points_won, :integer
    t.column :net_points_played, :integer
    t.column :points_won, :integer
    t.column :winners, :integer
    t.column :unforced_errors, :integer
    t.column :winners_forehand, :integer
    t.column :winners_backhand, :integer
    t.column :winners_volley, :integer
  end

  create_table :wagering_moneylines do |t|
    t.references :bookmakers
    t.references :events
    t.column :date_time, :timestamp
    t.references :teams
    t.column :person_id, :integer
    t.column :rotation_key, :string, :limit => 100
    t.column :comment, :string, :limit => 255
    t.column :vigorish, :string, :limit => 100
    t.column :line, :string, :limit => 100
    t.column :line_opening, :string, :limit => 100
    t.column :prediction, :string, :limit => 100
  end

  create_table :wagering_odds_lines do |t|
    t.references :bookmakers
    t.references :events
    t.column :date_time, :timestamp
    t.references :teams
    t.column :person_id, :integer
    t.column :rotation_key, :string, :limit => 100
    t.column :comment, :string, :limit => 255
    t.column :numerator, :string, :limit => 100
    t.column :denominator, :string, :limit => 100
    t.column :prediction, :string, :limit => 100
    t.column :payout_calculation, :string, :limit => 100
    t.column :payout_amount, :string, :limit => 100
  end

  create_table :wagering_runlines do |t|
    t.references :bookmakers
    t.references :events
    t.column :date_time, :timestamp
    t.references :teams
    t.column :person_id, :integer
    t.column :rotation_key, :string, :limit => 100
    t.column :comment, :string, :limit => 255
    t.column :vigorish, :string, :limit => 100
    t.column :line, :string, :limit => 100
    t.column :line_opening, :string, :limit => 100
    t.column :line_value, :string, :limit => 100
    t.column :prediction, :string, :limit => 100
  end

  create_table :wagering_straight_spread_lines do |t|
    t.references :bookmakers
    t.references :events
    t.column :date_time, :timestamp
    t.references :teams
    t.column :person_id, :integer
    t.column :rotation_key, :string, :limit => 100
    t.column :comment, :string, :limit => 255
    t.column :vigorish, :string, :limit => 100
    t.column :line_value, :string, :limit => 100
    t.column :line_value_opening, :string, :limit => 100
    t.column :prediction, :string, :limit => 100
  end

  create_table :wagering_total_score_lines do |t|
    t.references :bookmakers
    t.references :events
    t.column :date_time, :timestamp
    t.references :teams
    t.column :person_id, :integer
    t.column :rotation_key, :string, :limit => 100
    t.column :comment, :string, :limit => 255
    t.column :vigorish, :string, :limit => 100
    t.column :line_over, :string, :limit => 100
    t.column :line_under, :string, :limit => 100
    t.column :total, :string, :limit => 100
    t.column :total_opening, :string, :limit => 100
    t.column :prediction, :string, :limit => 100
  end

  create_table :weather_conditions do |t|
    t.references :events
    t.column :temperature, :string, :limit => 100
    t.column :temperature_units, :string, :limit => 40
    t.column :humidity, :string, :limit => 100
    t.column :clouds, :string, :limit => 100
    t.column :wind_direction, :string, :limit => 100
    t.column :wind_velocity, :string, :limit => 100
    t.column :weather_code, :string, :limit => 100
  end
  add_index(:weather_conditions, [:event_id], :name => :IDX_FK_wea_con_eve_id__eve_id)

end
end

def self.down
    # drop all the tables
  end
end
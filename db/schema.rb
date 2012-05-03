# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120502155251) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.integer "location_id",                  :null => false
    t.string  "language",      :limit => 100
    t.string  "suite",         :limit => 100
    t.string  "floor",         :limit => 100
    t.string  "building",      :limit => 100
    t.string  "street_number", :limit => 100
    t.string  "street_prefix", :limit => 100
    t.string  "street",        :limit => 100
    t.string  "street_suffix", :limit => 100
    t.string  "neighborhood",  :limit => 100
    t.string  "district",      :limit => 100
    t.string  "locality",      :limit => 100
    t.string  "county",        :limit => 100
    t.string  "region",        :limit => 100
    t.string  "postal_code",   :limit => 100
    t.string  "country",       :limit => 100
  end

  add_index "addresses", ["locality"], :name => "IDX_addresses_1"
  add_index "addresses", ["location_id"], :name => "IDX_FK_add_loc_id__loc_id"
  add_index "addresses", ["postal_code"], :name => "IDX_addresses_3"
  add_index "addresses", ["region"], :name => "IDX_addresses_2"

  create_table "admin_notes", :force => true do |t|
    t.integer  "resource_id",     :null => false
    t.string   "resource_type",   :null => false
    t.integer  "admin_user_id"
    t.string   "admin_user_type"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "admin_notes", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "affiliation_phases", :force => true do |t|
    t.integer  "affiliation_id",          :null => false
    t.integer  "root_id"
    t.integer  "ancestor_affiliation_id"
    t.integer  "start_season_id"
    t.datetime "start_date_time"
    t.integer  "end_season_id"
    t.datetime "end_date_time"
  end

  add_index "affiliation_phases", ["affiliation_id"], :name => "FK_affiliations_affiliation_phases"
  add_index "affiliation_phases", ["ancestor_affiliation_id"], :name => "FK_affiliations_affiliation_phases1"
  add_index "affiliation_phases", ["end_season_id"], :name => "FK_seasons_affiliation_phases1"
  add_index "affiliation_phases", ["start_season_id"], :name => "FK_seasons_affiliation_phases"

  create_table "affiliations", :force => true do |t|
    t.string  "affiliation_key",  :limit => 100, :null => false
    t.string  "affiliation_type", :limit => 100
    t.integer "publisher_id",                    :null => false
  end

  add_index "affiliations", ["affiliation_key", "affiliation_type", "publisher_id"], :name => "IDX_affiliations_3"
  add_index "affiliations", ["affiliation_key"], :name => "IDX_affiliations_1"
  add_index "affiliations", ["affiliation_type"], :name => "IDX_affiliations_2"
  add_index "affiliations", ["publisher_id"], :name => "IDX_FK_aff_pub_id__pub_id"

  create_table "affiliations_documents", :id => false, :force => true do |t|
    t.integer "affiliation_id", :null => false
    t.integer "document_id",    :null => false
  end

  add_index "affiliations_documents", ["affiliation_id"], :name => "FK_aff_doc_aff_id__aff_id"
  add_index "affiliations_documents", ["document_id"], :name => "FK_aff_doc_doc_id__doc_id"

  create_table "affiliations_events", :id => false, :force => true do |t|
    t.integer "affiliation_id", :null => false
    t.integer "event_id",       :null => false
  end

  add_index "affiliations_events", ["affiliation_id"], :name => "FK_aff_eve_aff_id__aff_id"
  add_index "affiliations_events", ["event_id"], :name => "FK_aff_eve_eve_id__eve_id"

  create_table "affiliations_media", :id => false, :force => true do |t|
    t.integer "affiliation_id", :null => false
    t.integer "media_id",       :null => false
  end

  add_index "affiliations_media", ["affiliation_id"], :name => "FK_aff_med_aff_id__aff_id"
  add_index "affiliations_media", ["media_id"], :name => "FK_aff_med_med_id__med_id"

  create_table "american_football_action_participants", :force => true do |t|
    t.integer "american_football_action_play_id",                :null => false
    t.integer "person_id",                                       :null => false
    t.string  "participant_role",                 :limit => 100, :null => false
    t.string  "score_type",                       :limit => 100
    t.integer "field_line"
    t.integer "yardage"
    t.integer "score_credit"
    t.integer "yards_gained"
  end

  add_index "american_football_action_participants", ["american_football_action_play_id"], :name => "IDX_FK_ame_foo_act_par_ame_foo_act_pla_id__ame_foo_act_pla_id"
  add_index "american_football_action_participants", ["participant_role"], :name => "IDX_american_football_action_participants_1"
  add_index "american_football_action_participants", ["person_id"], :name => "IDX_FK_ame_foo_act_par_per_id__per_id"
  add_index "american_football_action_participants", ["score_type"], :name => "IDX_american_football_action_participants_2"

  create_table "american_football_action_plays", :force => true do |t|
    t.integer "american_football_event_state_id",                :null => false
    t.integer "team_id"
    t.string  "play_type",                        :limit => 100
    t.string  "score_attempt_type",               :limit => 100
    t.string  "touchdown_type",                   :limit => 100
    t.string  "drive_result",                     :limit => 100
    t.integer "points"
    t.string  "comment",                          :limit => 512
    t.string  "recipient_type",                   :limit => 100
    t.string  "penalty_side",                     :limit => 100
    t.string  "penalty_level",                    :limit => 100
    t.integer "penalty_yards"
  end

  add_index "american_football_action_plays", ["american_football_event_state_id"], :name => "IDX_FK_ame_foo_act_pla_ame_foo_eve_sta_id__ame_foo_eve_sta_id"
  add_index "american_football_action_plays", ["drive_result"], :name => "IDX_american_football_action_plays_3"
  add_index "american_football_action_plays", ["play_type"], :name => "IDX_american_football_action_plays_1"
  add_index "american_football_action_plays", ["score_attempt_type"], :name => "IDX_american_football_action_plays_2"
  add_index "american_football_action_plays", ["team_id"], :name => "FK_american_football_action_plays_team_id_teams_id"

  create_table "american_football_defensive_stats", :force => true do |t|
    t.string  "tackles_total",                                  :limit => 100
    t.string  "tackles_solo",                                   :limit => 100
    t.string  "tackles_assists",                                :limit => 100
    t.string  "interceptions_total",                            :limit => 100
    t.string  "interceptions_yards",                            :limit => 100
    t.string  "interceptions_average",                          :limit => 100
    t.string  "interceptions_longest",                          :limit => 100
    t.string  "interceptions_touchdown",                        :limit => 100
    t.string  "quarterback_hurries",                            :limit => 100
    t.string  "sacks_total",                                    :limit => 100
    t.string  "sacks_yards",                                    :limit => 100
    t.string  "passes_defensed",                                :limit => 100
    t.integer "first_downs_against_total"
    t.integer "first_downs_against_rushing"
    t.integer "first_downs_against_passing"
    t.integer "first_downs_against_penalty"
    t.integer "conversions_third_down_against"
    t.integer "conversions_third_down_against_attempts"
    t.decimal "conversions_third_down_against_percentage",                     :precision => 5, :scale => 2
    t.integer "conversions_fourth_down_against"
    t.integer "conversions_fourth_down_against_attempts"
    t.decimal "conversions_fourth_down_against_percentage",                    :precision => 5, :scale => 2
    t.integer "two_point_conversions_against"
    t.integer "two_point_conversions_against_attempts"
    t.integer "offensive_plays_against_touchdown"
    t.decimal "offensive_plays_against_average_yards_per_game",                :precision => 5, :scale => 2
    t.integer "rushes_against_attempts"
    t.integer "rushes_against_yards"
    t.decimal "rushing_against_average_yards_per_game",                        :precision => 5, :scale => 2
    t.integer "rushes_against_touchdowns"
    t.decimal "rushes_against_average_yards_per",                              :precision => 5, :scale => 2
    t.integer "rushes_against_longest"
    t.integer "receptions_against_total"
    t.integer "receptions_against_yards"
    t.integer "receptions_against_touchdowns"
    t.decimal "receptions_against_average_yards_per",                          :precision => 5, :scale => 2
    t.integer "receptions_against_longest"
    t.integer "passes_against_yards_net"
    t.integer "passes_against_yards_gross"
    t.integer "passes_against_attempts"
    t.integer "passes_against_completions"
    t.decimal "passes_against_percentage",                                     :precision => 5, :scale => 2
    t.decimal "passes_against_average_yards_per_game",                         :precision => 5, :scale => 2
    t.decimal "passes_against_average_yards_per",                              :precision => 5, :scale => 2
    t.integer "passes_against_touchdowns"
    t.decimal "passes_against_touchdowns_percentage",                          :precision => 5, :scale => 2
    t.integer "passes_against_longest"
    t.decimal "passes_against_rating",                                         :precision => 5, :scale => 2
    t.decimal "interceptions_percentage",                                      :precision => 5, :scale => 2
    t.integer "defense_rank"
    t.integer "defense_rank_pass"
    t.integer "defense_rank_rush"
    t.integer "turnovers_takeaway"
  end

  create_table "american_football_down_progress_stats", :force => true do |t|
    t.string "first_downs_total",                  :limit => 100
    t.string "first_downs_pass",                   :limit => 100
    t.string "first_downs_run",                    :limit => 100
    t.string "first_downs_penalty",                :limit => 100
    t.string "conversions_third_down",             :limit => 100
    t.string "conversions_third_down_attempts",    :limit => 100
    t.string "conversions_third_down_percentage",  :limit => 100
    t.string "conversions_fourth_down",            :limit => 100
    t.string "conversions_fourth_down_attempts",   :limit => 100
    t.string "conversions_fourth_down_percentage", :limit => 100
  end

  create_table "american_football_event_states", :force => true do |t|
    t.integer "event_id",                             :null => false
    t.integer "current_state",         :limit => 2
    t.integer "sequence_number"
    t.integer "period_value"
    t.string  "period_time_elapsed",   :limit => 100
    t.string  "period_time_remaining", :limit => 100
    t.string  "clock_state",           :limit => 100
    t.integer "down"
    t.integer "team_in_possession_id"
    t.integer "score_team"
    t.integer "score_team_opposing"
    t.integer "distance_for_1st_down"
    t.string  "field_side",            :limit => 100
    t.integer "field_line"
    t.string  "context",               :limit => 40
    t.integer "score_team_away"
    t.integer "score_team_home"
    t.integer "document_id"
  end

  add_index "american_football_event_states", ["context"], :name => "IDX_american_football_event_states_context"
  add_index "american_football_event_states", ["current_state"], :name => "IDX_american_football_event_states_1"
  add_index "american_football_event_states", ["event_id"], :name => "IDX_FK_ame_foo_eve_sta_eve_id__eve_id"
  add_index "american_football_event_states", ["sequence_number"], :name => "IDX_american_football_event_states_seq_num"
  add_index "american_football_event_states", ["team_in_possession_id"], :name => "FK_ame_foo_eve_sta_tea_in_pos_id__tea_id"

  create_table "american_football_fumbles_stats", :force => true do |t|
    t.string  "fumbles_committed",                     :limit => 100
    t.string  "fumbles_forced",                        :limit => 100
    t.string  "fumbles_recovered",                     :limit => 100
    t.string  "fumbles_lost",                          :limit => 100
    t.string  "fumbles_yards_gained",                  :limit => 100
    t.string  "fumbles_own_committed",                 :limit => 100
    t.string  "fumbles_own_recovered",                 :limit => 100
    t.string  "fumbles_own_lost",                      :limit => 100
    t.string  "fumbles_own_yards_gained",              :limit => 100
    t.string  "fumbles_opposing_committed",            :limit => 100
    t.string  "fumbles_opposing_recovered",            :limit => 100
    t.string  "fumbles_opposing_lost",                 :limit => 100
    t.string  "fumbles_opposing_yards_gained",         :limit => 100
    t.integer "fumbles_own_touchdowns"
    t.integer "fumbles_opposing_touchdowns"
    t.integer "fumbles_committed_defense"
    t.integer "fumbles_committed_special_teams"
    t.integer "fumbles_committed_other"
    t.integer "fumbles_lost_defense"
    t.integer "fumbles_lost_special_teams"
    t.integer "fumbles_lost_other"
    t.integer "fumbles_forced_defense"
    t.integer "fumbles_recovered_defense"
    t.integer "fumbles_recovered_special_teams"
    t.integer "fumbles_recovered_other"
    t.integer "fumbles_recovered_yards_defense"
    t.integer "fumbles_recovered_yards_special_teams"
    t.integer "fumbles_recovered_yards_other"
  end

  create_table "american_football_offensive_stats", :force => true do |t|
    t.string  "offensive_plays_yards",             :limit => 100
    t.string  "offensive_plays_number",            :limit => 100
    t.string  "offensive_plays_average_yards_per", :limit => 100
    t.string  "possession_duration",               :limit => 100
    t.string  "turnovers_giveaway",                :limit => 100
    t.integer "tackles"
    t.integer "tackles_assists"
    t.integer "offensive_rank"
  end

  create_table "american_football_passing_stats", :force => true do |t|
    t.string  "passes_attempts",                 :limit => 100
    t.string  "passes_completions",              :limit => 100
    t.string  "passes_percentage",               :limit => 100
    t.string  "passes_yards_gross",              :limit => 100
    t.string  "passes_yards_net",                :limit => 100
    t.string  "passes_yards_lost",               :limit => 100
    t.string  "passes_touchdowns",               :limit => 100
    t.string  "passes_touchdowns_percentage",    :limit => 100
    t.string  "passes_interceptions",            :limit => 100
    t.string  "passes_interceptions_percentage", :limit => 100
    t.string  "passes_longest",                  :limit => 100
    t.string  "passes_average_yards_per",        :limit => 100
    t.string  "passer_rating",                   :limit => 100
    t.string  "receptions_total",                :limit => 100
    t.string  "receptions_yards",                :limit => 100
    t.string  "receptions_touchdowns",           :limit => 100
    t.string  "receptions_first_down",           :limit => 100
    t.string  "receptions_longest",              :limit => 100
    t.string  "receptions_average_yards_per",    :limit => 100
    t.integer "passing_rank"
  end

  create_table "american_football_penalties_stats", :force => true do |t|
    t.string "penalties_total",     :limit => 100
    t.string "penalty_yards",       :limit => 100
    t.string "penalty_first_downs", :limit => 100
  end

  create_table "american_football_rushing_stats", :force => true do |t|
    t.string  "rushes_attempts",           :limit => 100
    t.string  "rushes_yards",              :limit => 100
    t.string  "rushes_touchdowns",         :limit => 100
    t.string  "rushing_average_yards_per", :limit => 100
    t.string  "rushes_first_down",         :limit => 100
    t.string  "rushes_longest",            :limit => 100
    t.integer "rushing_rank"
  end

  create_table "american_football_sacks_against_stats", :force => true do |t|
    t.string "sacks_against_yards", :limit => 100
    t.string "sacks_against_total", :limit => 100
  end

  create_table "american_football_scoring_stats", :force => true do |t|
    t.string  "touchdowns_total",               :limit => 100
    t.string  "touchdowns_passing",             :limit => 100
    t.string  "touchdowns_rushing",             :limit => 100
    t.string  "touchdowns_special_teams",       :limit => 100
    t.string  "touchdowns_defensive",           :limit => 100
    t.string  "extra_points_attempts",          :limit => 100
    t.string  "extra_points_made",              :limit => 100
    t.string  "extra_points_missed",            :limit => 100
    t.string  "extra_points_blocked",           :limit => 100
    t.string  "field_goal_attempts",            :limit => 100
    t.string  "field_goals_made",               :limit => 100
    t.string  "field_goals_missed",             :limit => 100
    t.string  "field_goals_blocked",            :limit => 100
    t.string  "safeties_against",               :limit => 100
    t.string  "two_point_conversions_attempts", :limit => 100
    t.string  "two_point_conversions_made",     :limit => 100
    t.string  "touchbacks_total",               :limit => 100
    t.integer "safeties_against_opponent"
  end

  create_table "american_football_special_teams_stats", :force => true do |t|
    t.string  "returns_punt_total",                    :limit => 100
    t.string  "returns_punt_yards",                    :limit => 100
    t.string  "returns_punt_average",                  :limit => 100
    t.string  "returns_punt_longest",                  :limit => 100
    t.string  "returns_punt_touchdown",                :limit => 100
    t.string  "returns_kickoff_total",                 :limit => 100
    t.string  "returns_kickoff_yards",                 :limit => 100
    t.string  "returns_kickoff_average",               :limit => 100
    t.string  "returns_kickoff_longest",               :limit => 100
    t.string  "returns_kickoff_touchdown",             :limit => 100
    t.string  "returns_total",                         :limit => 100
    t.string  "returns_yards",                         :limit => 100
    t.string  "punts_total",                           :limit => 100
    t.string  "punts_yards_gross",                     :limit => 100
    t.string  "punts_yards_net",                       :limit => 100
    t.string  "punts_longest",                         :limit => 100
    t.string  "punts_inside_20",                       :limit => 100
    t.string  "punts_inside_20_percentage",            :limit => 100
    t.string  "punts_average",                         :limit => 100
    t.string  "punts_blocked",                         :limit => 100
    t.string  "touchbacks_total",                      :limit => 100
    t.string  "touchbacks_total_percentage",           :limit => 100
    t.string  "touchbacks_kickoffs",                   :limit => 100
    t.string  "touchbacks_kickoffs_percentage",        :limit => 100
    t.string  "touchbacks_punts",                      :limit => 100
    t.string  "touchbacks_punts_percentage",           :limit => 100
    t.string  "touchbacks_interceptions",              :limit => 100
    t.string  "touchbacks_interceptions_percentage",   :limit => 100
    t.string  "fair_catches",                          :limit => 100
    t.integer "punts_against_blocked"
    t.integer "field_goals_against_attempts_1_to_19"
    t.integer "field_goals_against_made_1_to_19"
    t.integer "field_goals_against_attempts_20_to_29"
    t.integer "field_goals_against_made_20_to_29"
    t.integer "field_goals_against_attempts_30_to_39"
    t.integer "field_goals_against_made_30_to_39"
    t.integer "field_goals_against_attempts_40_to_49"
    t.integer "field_goals_against_made_40_to_49"
    t.integer "field_goals_against_attempts_50_plus"
    t.integer "field_goals_against_made_50_plus"
    t.integer "field_goals_against_attempts"
    t.integer "extra_points_against_attempts"
    t.integer "tackles"
    t.integer "tackles_assists"
  end

  create_table "american_football_team_stats", :force => true do |t|
    t.string "yards_per_attempt",         :limit => 100
    t.string "average_starting_position", :limit => 100
    t.string "timeouts",                  :limit => 100
    t.string "time_of_possession",        :limit => 100
    t.string "turnover_ratio",            :limit => 100
  end

  create_table "awards", :force => true do |t|
    t.string  "participant_type",   :limit => 100, :null => false
    t.integer "participant_id",                    :null => false
    t.string  "award_type",         :limit => 100
    t.string  "name",               :limit => 100
    t.integer "total"
    t.string  "rank",               :limit => 100
    t.string  "award_value",        :limit => 100
    t.string  "currency",           :limit => 100
    t.string  "date_coverage_type", :limit => 100
    t.integer "date_coverage_id"
  end

  create_table "baseball_action_contact_details", :force => true do |t|
    t.integer "baseball_action_pitch_id",                :null => false
    t.string  "location",                 :limit => 100
    t.string  "strength",                 :limit => 100
    t.integer "velocity"
    t.string  "comment",                  :limit => 512
    t.string  "trajectory_coordinates",   :limit => 100
    t.string  "trajectory_formula",       :limit => 100
  end

  add_index "baseball_action_contact_details", ["baseball_action_pitch_id"], :name => "FK_bas_act_con_det_bas_act_pit_id__bas_act_pit_id"

  create_table "baseball_action_pitches", :force => true do |t|
    t.integer "baseball_action_play_id",                                                   :null => false
    t.decimal "sequence_number",                             :precision => 4, :scale => 1
    t.integer "baseball_defensive_group_id"
    t.string  "umpire_call",                 :limit => 100
    t.string  "pitch_location",              :limit => 100
    t.string  "pitch_type",                  :limit => 100
    t.integer "pitch_velocity"
    t.string  "comment",                     :limit => 2048
    t.string  "trajectory_coordinates",      :limit => 512
    t.string  "trajectory_formula",          :limit => 100
    t.string  "ball_type",                   :limit => 40
    t.string  "strike_type",                 :limit => 40
    t.integer "strikes"
    t.integer "balls"
  end

  add_index "baseball_action_pitches", ["baseball_action_play_id"], :name => "FK_baseball_action_plays_baseball_action_pitches"
  add_index "baseball_action_pitches", ["baseball_defensive_group_id"], :name => "IDX_FK_bas_act_pit_bas_def_gro_id__bas_def_gro_id"
  add_index "baseball_action_pitches", ["pitch_type"], :name => "IDX_baseball_action_pitches_2"
  add_index "baseball_action_pitches", ["umpire_call"], :name => "IDX_baseball_action_pitches_1"

  create_table "baseball_action_plays", :force => true do |t|
    t.integer "baseball_event_state_id",                    :null => false
    t.string  "play_type",                   :limit => 100
    t.string  "out_type",                    :limit => 100
    t.string  "notation",                    :limit => 100
    t.text    "notation_yaml"
    t.integer "baseball_defensive_group_id"
    t.string  "comment",                     :limit => 512
    t.string  "runner_on_first_advance",     :limit => 40
    t.string  "runner_on_second_advance",    :limit => 40
    t.string  "runner_on_third_advance",     :limit => 40
    t.integer "outs_recorded"
    t.integer "rbi"
    t.integer "runs_scored"
    t.string  "earned_runs_scored",          :limit => 100
  end

  add_index "baseball_action_plays", ["baseball_event_state_id"], :name => "IDX_FK_bas_act_pla_bas_eve_sta_id__bas_eve_sta_id"
  add_index "baseball_action_plays", ["out_type"], :name => "IDX_baseball_action_plays_2"
  add_index "baseball_action_plays", ["play_type"], :name => "IDX_baseball_action_plays_1"

  create_table "baseball_action_substitutions", :force => true do |t|
    t.integer "baseball_event_state_id",                                                   :null => false
    t.decimal "sequence_number",                             :precision => 4, :scale => 1
    t.string  "person_type",                  :limit => 100
    t.integer "person_original_id"
    t.integer "person_original_position_id"
    t.integer "person_original_lineup_slot"
    t.integer "person_replacing_id"
    t.integer "person_replacing_position_id"
    t.integer "person_replacing_lineup_slot"
    t.string  "substitution_reason",          :limit => 100
    t.string  "comment",                      :limit => 512
  end

  add_index "baseball_action_substitutions", ["baseball_event_state_id"], :name => "FK_bas_act_sub_bas_eve_sta_id__bas_eve_sta_id"
  add_index "baseball_action_substitutions", ["person_original_id"], :name => "FK_bas_act_sub_per_ori_id__per_id"
  add_index "baseball_action_substitutions", ["person_original_position_id"], :name => "FK_bas_act_sub_per_ori_pos_id__pos_id"
  add_index "baseball_action_substitutions", ["person_replacing_id"], :name => "FK_bas_act_sub_per_rep_id__per_id"
  add_index "baseball_action_substitutions", ["person_replacing_position_id"], :name => "FK_bas_act_sub_per_rep_pos_id__pos_id"

  create_table "baseball_defensive_group", :force => true do |t|
  end

  create_table "baseball_defensive_players", :force => true do |t|
    t.integer "baseball_defensive_group_id", :null => false
    t.integer "player_id",                   :null => false
    t.integer "position_id",                 :null => false
  end

  add_index "baseball_defensive_players", ["baseball_defensive_group_id"], :name => "FK_bas_def_pla_bas_def_gro_id__bas_def_gro_id"
  add_index "baseball_defensive_players", ["player_id"], :name => "FK_bas_def_pla_pla_id__per_id"
  add_index "baseball_defensive_players", ["position_id"], :name => "FK_bas_def_pla_pos_id__pos_id"

  create_table "baseball_defensive_stats", :force => true do |t|
    t.integer "double_plays"
    t.integer "triple_plays"
    t.integer "putouts"
    t.integer "assists"
    t.integer "errors"
    t.float   "fielding_percentage"
    t.float   "defensive_average"
    t.integer "errors_passed_ball"
    t.integer "errors_catchers_interference"
    t.integer "stolen_bases_average"
    t.integer "stolen_bases_caught"
  end

  create_table "baseball_event_states", :force => true do |t|
    t.integer "event_id",                                                           :null => false
    t.integer "current_state",         :limit => 2
    t.decimal "sequence_number",                      :precision => 4, :scale => 1
    t.integer "at_bat_number"
    t.integer "inning_value"
    t.string  "inning_half",           :limit => 100
    t.integer "outs"
    t.integer "balls"
    t.integer "strikes"
    t.integer "runner_on_first_id"
    t.integer "runner_on_second_id"
    t.integer "runner_on_third_id"
    t.integer "runner_on_first",       :limit => 2
    t.integer "runner_on_second",      :limit => 2
    t.integer "runner_on_third",       :limit => 2
    t.integer "runs_this_inning_half"
    t.integer "pitcher_id"
    t.integer "batter_id"
    t.string  "batter_side",           :limit => 100
    t.string  "context",               :limit => 40
    t.integer "document_id"
  end

  add_index "baseball_event_states", ["batter_id"], :name => "FK_bas_eve_sta_bat_id__per_id"
  add_index "baseball_event_states", ["context"], :name => "IDX_baseball_event_states_context"
  add_index "baseball_event_states", ["current_state"], :name => "IDX_baseball_event_states_1"
  add_index "baseball_event_states", ["event_id"], :name => "IDX_FK_bas_eve_sta_eve_id__eve_id"
  add_index "baseball_event_states", ["pitcher_id"], :name => "FK_bas_eve_sta_pit_id__per_id"
  add_index "baseball_event_states", ["runner_on_first_id"], :name => "FK_bas_eve_sta_run_on_fir_id__per_id"
  add_index "baseball_event_states", ["runner_on_second_id"], :name => "FK_bas_eve_sta_run_on_sec_id__per_id"
  add_index "baseball_event_states", ["runner_on_third_id"], :name => "FK_bas_eve_sta_run_on_thi_id__per_id"
  add_index "baseball_event_states", ["sequence_number"], :name => "IDX_baseball_event_states_seq_num"

  create_table "baseball_offensive_stats", :force => true do |t|
    t.float   "average"
    t.integer "runs_scored"
    t.integer "at_bats"
    t.integer "hits"
    t.integer "rbi"
    t.integer "total_bases"
    t.float   "slugging_percentage"
    t.integer "bases_on_balls"
    t.integer "strikeouts"
    t.integer "left_on_base"
    t.integer "left_in_scoring_position"
    t.integer "singles"
    t.integer "doubles"
    t.integer "triples"
    t.integer "home_runs"
    t.integer "grand_slams"
    t.float   "at_bats_per_rbi"
    t.float   "plate_appearances_per_rbi"
    t.float   "at_bats_per_home_run"
    t.float   "plate_appearances_per_home_run"
    t.integer "sac_flies"
    t.integer "sac_bunts"
    t.integer "grounded_into_double_play"
    t.integer "moved_up"
    t.float   "on_base_percentage"
    t.integer "stolen_bases"
    t.integer "stolen_bases_caught"
    t.float   "stolen_bases_average"
    t.integer "hit_by_pitch"
    t.float   "on_base_plus_slugging"
    t.integer "plate_appearances"
    t.integer "hits_extra_base"
    t.integer "pick_offs_against"
    t.integer "sacrifices"
    t.integer "outs_fly"
    t.integer "outs_ground"
    t.integer "reached_base_defensive_interference"
    t.integer "reached_base_error"
    t.integer "reached_base_fielder_choice"
    t.integer "double_plays_against"
    t.integer "triple_plays_against"
    t.integer "strikeouts_looking"
    t.integer "bases_on_balls_intentional"
  end

  create_table "baseball_pitching_stats", :force => true do |t|
    t.integer "runs_allowed"
    t.integer "singles_allowed"
    t.integer "doubles_allowed"
    t.integer "triples_allowed"
    t.integer "home_runs_allowed"
    t.string  "innings_pitched",            :limit => 20
    t.integer "hits"
    t.integer "earned_runs"
    t.integer "unearned_runs"
    t.integer "bases_on_balls"
    t.integer "bases_on_balls_intentional"
    t.integer "strikeouts"
    t.float   "strikeout_to_bb_ratio"
    t.integer "number_of_pitches"
    t.float   "era"
    t.integer "inherited_runners_scored"
    t.integer "pick_offs"
    t.integer "errors_hit_with_pitch"
    t.integer "errors_wild_pitch"
    t.integer "balks"
    t.integer "wins"
    t.integer "losses"
    t.integer "saves"
    t.integer "shutouts"
    t.integer "games_complete"
    t.integer "games_finished"
    t.float   "winning_percentage"
    t.string  "event_credit",               :limit => 40
    t.string  "save_credit",                :limit => 40
    t.integer "batters_doubles_against"
    t.integer "batters_triples_against"
    t.integer "outs_recorded"
    t.integer "batters_at_bats_against"
    t.integer "number_of_strikes"
    t.integer "wins_season"
    t.integer "losses_season"
    t.integer "saves_season"
    t.integer "saves_blown_season"
    t.integer "saves_blown"
  end

  create_table "basketball_defensive_stats", :force => true do |t|
    t.string "steals_total",    :limit => 100
    t.string "steals_per_game", :limit => 100
    t.string "blocks_total",    :limit => 100
    t.string "blocks_per_game", :limit => 100
  end

  create_table "basketball_event_states", :force => true do |t|
    t.integer "event_id",                             :null => false
    t.integer "current_state",         :limit => 1
    t.integer "sequence_number"
    t.string  "period_value",          :limit => 100
    t.string  "period_time_elapsed",   :limit => 100
    t.string  "period_time_remaining", :limit => 100
    t.string  "context",               :limit => 40
    t.integer "document_id"
  end

  add_index "basketball_event_states", ["context"], :name => "IDX_basketball_event_states_context"
  add_index "basketball_event_states", ["event_id"], :name => "IDX_FK_events_basketball_event_states"
  add_index "basketball_event_states", ["sequence_number"], :name => "IDX_basketball_event_states_seq_num"

  create_table "basketball_offensive_stats", :force => true do |t|
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.string  "field_goals_percentage",            :limit => 100
    t.string  "field_goals_per_game",              :limit => 100
    t.string  "field_goals_attempted_per_game",    :limit => 100
    t.string  "field_goals_percentage_adjusted",   :limit => 100
    t.integer "three_pointers_made"
    t.integer "three_pointers_attempted"
    t.string  "three_pointers_percentage",         :limit => 100
    t.string  "three_pointers_per_game",           :limit => 100
    t.string  "three_pointers_attempted_per_game", :limit => 100
    t.string  "free_throws_made",                  :limit => 100
    t.string  "free_throws_attempted",             :limit => 100
    t.string  "free_throws_percentage",            :limit => 100
    t.string  "free_throws_per_game",              :limit => 100
    t.string  "free_throws_attempted_per_game",    :limit => 100
    t.string  "points_scored_total",               :limit => 100
    t.string  "points_scored_per_game",            :limit => 100
    t.string  "assists_total",                     :limit => 100
    t.string  "assists_per_game",                  :limit => 100
    t.string  "turnovers_total",                   :limit => 100
    t.string  "turnovers_per_game",                :limit => 100
    t.string  "points_scored_off_turnovers",       :limit => 100
    t.string  "points_scored_in_paint",            :limit => 100
    t.string  "points_scored_on_second_chance",    :limit => 100
    t.string  "points_scored_on_fast_break",       :limit => 100
  end

  create_table "basketball_rebounding_stats", :force => true do |t|
    t.string "rebounds_total",          :limit => 100
    t.string "rebounds_per_game",       :limit => 100
    t.string "rebounds_defensive",      :limit => 100
    t.string "rebounds_offensive",      :limit => 100
    t.string "team_rebounds_total",     :limit => 100
    t.string "team_rebounds_per_game",  :limit => 100
    t.string "team_rebounds_defensive", :limit => 100
    t.string "team_rebounds_offensive", :limit => 100
  end

  create_table "basketball_team_stats", :force => true do |t|
    t.string "timeouts_left",   :limit => 100
    t.string "largest_lead",    :limit => 100
    t.string "fouls_total",     :limit => 100
    t.string "turnover_margin", :limit => 100
  end

  create_table "bookmakers", :force => true do |t|
    t.string  "bookmaker_key", :limit => 100
    t.integer "publisher_id",                 :null => false
    t.integer "location_id"
  end

  add_index "bookmakers", ["location_id"], :name => "FK_boo_loc_id__loc_id"
  add_index "bookmakers", ["publisher_id"], :name => "FK_boo_pub_id__pub_id"

  create_table "core_stats", :force => true do |t|
    t.string  "score",                     :limit => 100
    t.string  "score_opposing",            :limit => 100
    t.string  "score_attempts",            :limit => 100
    t.string  "score_attempts_opposing",   :limit => 100
    t.string  "score_percentage",          :limit => 100
    t.string  "score_percentage_opposing", :limit => 100
    t.string  "time_played_event",         :limit => 40
    t.string  "time_played_total",         :limit => 40
    t.string  "time_played_event_average", :limit => 40
    t.string  "events_played",             :limit => 40
    t.string  "events_started",            :limit => 40
    t.integer "position_id"
    t.integer "series_score"
    t.integer "series_score_opposing"
  end

  create_table "db_info", :id => false, :force => true do |t|
    t.string "version", :limit => 100, :default => "16", :null => false
  end

  add_index "db_info", ["version"], :name => "IDX_db_info_1"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "display_names", :force => true do |t|
    t.string  "language",     :limit => 100, :null => false
    t.string  "entity_type",  :limit => 100, :null => false
    t.integer "entity_id",                   :null => false
    t.string  "full_name",    :limit => 100
    t.string  "first_name",   :limit => 100
    t.string  "middle_name",  :limit => 100
    t.string  "last_name",    :limit => 100
    t.string  "alias",        :limit => 100
    t.string  "abbreviation", :limit => 100
    t.string  "short_name",   :limit => 100
    t.string  "prefix",       :limit => 20
    t.string  "suffix",       :limit => 20
  end

  add_index "display_names", ["entity_id"], :name => "IDX_display_names_1"
  add_index "display_names", ["entity_type", "entity_id", "full_name", "first_name", "last_name"], :name => "super_lucky_index"
  add_index "display_names", ["entity_type", "last_name", "first_name"], :name => "index_display_names_on_entity_type_and_first_name_and_last_name"
  add_index "display_names", ["entity_type"], :name => "IDX_display_names_2"

  create_table "document_classes", :force => true do |t|
    t.string "name", :limit => 100
  end

  add_index "document_classes", ["name"], :name => "IDX_document_classes_1"

  create_table "document_contents", :force => true do |t|
    t.integer "document_id",                  :null => false
    t.string  "sportsml",      :limit => 200
    t.text    "sportsml_blob"
    t.text    "abstract"
    t.text    "abstract_blob"
  end

  add_index "document_contents", ["document_id"], :name => "IDX_FK_doc_con_doc_id__doc_id"

  create_table "document_fixtures", :force => true do |t|
    t.string  "fixture_key",       :limit => 100
    t.integer "publisher_id",                     :null => false
    t.string  "name",              :limit => 100
    t.integer "document_class_id",                :null => false
  end

  add_index "document_fixtures", ["document_class_id"], :name => "IDX_FK_doc_fix_doc_cla_id__doc_cla_id"
  add_index "document_fixtures", ["fixture_key"], :name => "IDX_document_fixtures_1"
  add_index "document_fixtures", ["publisher_id"], :name => "IDX_FK_doc_fix_pub_id__pub_id"

  create_table "document_fixtures_events", :force => true do |t|
    t.integer  "document_fixture_id", :null => false
    t.integer  "event_id",            :null => false
    t.integer  "latest_document_id",  :null => false
    t.datetime "last_update"
  end

  add_index "document_fixtures_events", ["document_fixture_id"], :name => "IDX_FK_doc_fix_eve_doc_fix_id__doc_fix_id"
  add_index "document_fixtures_events", ["event_id"], :name => "IDX_FK_doc_fix_eve_eve_id__eve_id"
  add_index "document_fixtures_events", ["latest_document_id"], :name => "IDX_FK_doc_fix_eve_lat_doc_id__doc_id"

  create_table "document_package_entry", :force => true do |t|
    t.integer "document_package_id",                :null => false
    t.string  "rank",                :limit => 100
    t.integer "document_id",                        :null => false
    t.string  "headline",            :limit => 100
    t.string  "short_headline",      :limit => 100
  end

  add_index "document_package_entry", ["document_id"], :name => "FK_doc_pac_ent_doc_id__doc_id"
  add_index "document_package_entry", ["document_package_id"], :name => "FK_doc_pac_ent_doc_pac_id__doc_pac_id"

  create_table "document_packages", :force => true do |t|
    t.string "package_key",  :limit => 100
    t.string "package_name", :limit => 100
    t.date   "date_time"
  end

  create_table "documents", :force => true do |t|
    t.string   "doc_id",               :limit => 75,  :null => false
    t.integer  "publisher_id",                        :null => false
    t.datetime "date_time"
    t.string   "title"
    t.string   "language",             :limit => 100
    t.string   "priority",             :limit => 100
    t.string   "revision_id"
    t.string   "stats_coverage",       :limit => 100
    t.integer  "document_fixture_id",                 :null => false
    t.integer  "source_id"
    t.datetime "db_loading_date_time"
  end

  add_index "documents", ["date_time"], :name => "IDX_documents_3"
  add_index "documents", ["doc_id"], :name => "IDX_documents_1"
  add_index "documents", ["document_fixture_id"], :name => "IDX_FK_doc_doc_fix_id__doc_fix_id"
  add_index "documents", ["priority"], :name => "IDX_documents_4"
  add_index "documents", ["publisher_id"], :name => "IDX_FK_doc_pub_id__pub_id"
  add_index "documents", ["revision_id"], :name => "IDX_documents_5"
  add_index "documents", ["source_id"], :name => "IDX_FK_doc_sou_id__pub_id"

  create_table "documents_media", :force => true do |t|
    t.integer "document_id",      :null => false
    t.integer "media_id",         :null => false
    t.integer "media_caption_id", :null => false
  end

  add_index "documents_media", ["document_id"], :name => "FK_doc_med_doc_id__doc_id"
  add_index "documents_media", ["media_caption_id"], :name => "FK_doc_med_med_cap_id__med_cap_id"
  add_index "documents_media", ["media_id"], :name => "FK_doc_med_med_id__med_id"

  create_table "dynasty_accounts", :force => true do |t|
    t.string   "type"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.integer  "receivable_id"
    t.string   "receivable_type"
    t.integer  "amount_cents",             :limit => 8, :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "event_id"
    t.string   "event_type"
    t.integer  "receivable_balance_cents", :limit => 8
    t.integer  "payable_balance_cents",    :limit => 8
    t.datetime "transaction_datetime",                  :null => false
  end

  add_index "dynasty_accounts", ["transaction_datetime"], :name => "index_dynasty_accounts_on_transaction_datetime"

  create_table "dynasty_clock", :force => true do |t|
    t.datetime "time"
  end

  create_table "dynasty_draft_picks", :force => true do |t|
    t.integer  "player_id"
    t.integer  "draft_id",   :default => 0, :null => false
    t.integer  "team_id",                   :null => false
    t.integer  "pick_order", :default => 0, :null => false
    t.datetime "picked_at"
    t.integer  "round",                     :null => false
  end

  add_index "dynasty_draft_picks", ["draft_id"], :name => "index_dynasty_draft_picks_on_draft_id"
  add_index "dynasty_draft_picks", ["player_id"], :name => "index_dynasty_draft_picks_on_player_id"
  add_index "dynasty_draft_picks", ["team_id"], :name => "index_dynasty_draft_picks_on_team_id"

  create_table "dynasty_drafts", :force => true do |t|
    t.datetime "start_datetime"
    t.datetime "finished_at"
    t.integer  "league_id"
    t.string   "state"
  end

  add_index "dynasty_drafts", ["league_id"], :name => "index_drafts_league"
  add_index "dynasty_drafts", ["state"], :name => "index_dynasty_drafts_on_state"

  create_table "dynasty_event_subscriptions", :force => true do |t|
    t.integer "user_id",  :null => false
    t.string  "event_id", :null => false
    t.string  "notifier", :null => false
  end

  add_index "dynasty_event_subscriptions", ["user_id", "event_id", "notifier"], :name => "index_dynasty_notifications_on_user_id_and_event_id_and_notifier"

  create_table "dynasty_events", :force => true do |t|
    t.string   "type",         :limit => 32
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "processed_at"
  end

  create_table "dynasty_games", :force => true do |t|
    t.integer  "league_id"
    t.integer  "home_team_id",                                  :null => false
    t.integer  "away_team_id",                                  :null => false
    t.decimal  "home_team_score", :precision => 4, :scale => 1
    t.decimal  "away_team_score", :precision => 4, :scale => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.integer  "event_id"
    t.string   "event_type"
  end

  add_index "dynasty_games", ["id", "league_id", "date"], :name => "index_dynasty_games_on_id_and_league_id_and_date"
  add_index "dynasty_games", ["league_id", "event_id", "event_type"], :name => "index_dynasty_games_on_league_id_and_event_id_and_event_type"
  add_index "dynasty_games", ["league_id", "home_team_id", "away_team_id"], :name => "index_dynasty_games_on_league_and_teams", :unique => true

  create_table "dynasty_leagues", :force => true do |t|
    t.string   "name",          :limit => 50,                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "public",                      :default => true
    t.string   "password",      :limit => 32
    t.integer  "teams_count"
    t.integer  "balance_cents", :limit => 8,  :default => 0
  end

  add_index "dynasty_leagues", ["id", "name", "teams_count", "public"], :name => "index_leagues_on_name_size_team_count_public"
  add_index "dynasty_leagues", ["id"], :name => "index_dynasty_leagues_on_id_and_clock_id"
  add_index "dynasty_leagues", ["slug"], :name => "index_leagues_on_slug", :unique => true

  create_table "dynasty_lineups", :force => true do |t|
    t.integer "position_id"
    t.boolean "flex"
    t.integer "string"
  end

  add_index "dynasty_lineups", ["position_id", "flex"], :name => "index_dynasty_lineups_on_position_id_and_flex"
  add_index "dynasty_lineups", ["string"], :name => "index_dynasty_lineups_on_string"

  create_table "dynasty_player_contracts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "amount"
    t.integer  "length"
    t.integer  "end_year"
    t.integer  "summary"
    t.string   "free_agent_year"
    t.integer  "bye_week"
    t.string   "depth"
    t.integer  "guaranteed"
  end

  add_index "dynasty_player_contracts", ["person_id", "amount", "bye_week"], :name => "index_player_contracts_player_amount_bye"

  create_table "dynasty_player_event_points", :force => true do |t|
    t.integer  "player_id",            :default => 0, :null => false
    t.integer  "event_id",             :default => 0, :null => false
    t.integer  "points",               :default => 0, :null => false
    t.integer  "defensive_points",     :default => 0, :null => false
    t.integer  "fumbles_points",       :default => 0, :null => false
    t.integer  "passing_points",       :default => 0, :null => false
    t.integer  "rushing_points",       :default => 0, :null => false
    t.integer  "sacks_against_points", :default => 0, :null => false
    t.integer  "scoring_points",       :default => 0, :null => false
    t.integer  "special_teams_points", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "event_date"
    t.integer  "metadata_id"
  end

  add_index "dynasty_player_event_points", ["event_id"], :name => "index_dynasty_player_event_points_on_event_id"
  add_index "dynasty_player_event_points", ["metadata_id"], :name => "index_dynasty_player_event_points_on_metadata_id"
  add_index "dynasty_player_event_points", ["player_id"], :name => "index_dynasty_player_event_points_on_player_id"

  create_table "dynasty_player_points", :force => true do |t|
    t.integer  "points",                                 :null => false
    t.integer  "player_id",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year",                 :default => 2000, :null => false
    t.integer  "defensive_points",     :default => 0,    :null => false
    t.integer  "fumbles_points",       :default => 0,    :null => false
    t.integer  "passing_points",       :default => 0,    :null => false
    t.integer  "rushing_points",       :default => 0,    :null => false
    t.integer  "sacks_against_points", :default => 0,    :null => false
    t.integer  "scoring_points",       :default => 0,    :null => false
    t.integer  "special_teams_points", :default => 0,    :null => false
    t.integer  "games_played",         :default => 0,    :null => false
  end

  add_index "dynasty_player_points", ["defensive_points"], :name => "index_dynasty_player_points_on_defensive_points"
  add_index "dynasty_player_points", ["fumbles_points"], :name => "index_dynasty_player_points_on_fumbles_points"
  add_index "dynasty_player_points", ["games_played"], :name => "index_dynasty_player_points_on_games_played"
  add_index "dynasty_player_points", ["passing_points"], :name => "index_dynasty_player_points_on_passing_points"
  add_index "dynasty_player_points", ["player_id", "year"], :name => "index_dynasty_player_points_on_player_id_and_year", :unique => true
  add_index "dynasty_player_points", ["player_id"], :name => "index_dynasty_player_points_on_player_id"
  add_index "dynasty_player_points", ["points"], :name => "index_dynasty_player_points_on_points"
  add_index "dynasty_player_points", ["rushing_points"], :name => "index_dynasty_player_points_on_rushing_points"
  add_index "dynasty_player_points", ["sacks_against_points"], :name => "index_dynasty_player_points_on_sacks_against_points"
  add_index "dynasty_player_points", ["scoring_points"], :name => "index_dynasty_player_points_on_scoring_points"
  add_index "dynasty_player_points", ["special_teams_points"], :name => "index_dynasty_player_points_on_special_teams_points"
  add_index "dynasty_player_points", ["year", "points", "player_id"], :name => "index_dynasty_player_points_on_year_and_points_and_player_id"
  add_index "dynasty_player_points", ["year", "points"], :name => "index_dynasty_player_points_on_year_and_points"
  add_index "dynasty_player_points", ["year"], :name => "index_dynasty_player_points_on_year"

  create_table "dynasty_player_positions", :id => false, :force => true do |t|
    t.integer "player_id"
    t.integer "position_id"
  end

  add_index "dynasty_player_positions", ["player_id", "position_id"], :name => "index_dynasty_player_positions_on_player_id_and_position_id", :unique => true
  add_index "dynasty_player_positions", ["position_id", "player_id"], :name => "index_dynasty_player_positions_on_position_id_and_player_id", :unique => true

  create_table "dynasty_player_team_points", :force => true do |t|
    t.integer  "team_id"
    t.integer  "game_id"
    t.integer  "lineup_id"
    t.integer  "player_point_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "dynasty_player_team_points", ["team_id", "game_id", "player_point_id", "lineup_id"], :name => "index_dynasty_player_team_points_on_all"

  create_table "dynasty_player_teams", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lineup_id"
  end

  add_index "dynasty_player_teams", ["player_id", "team_id", "lineup_id"], :name => "index_dynasty_player_teams_on_player_and_team_and_lineup"
  add_index "dynasty_player_teams", ["team_id", "lineup_id"], :name => "index_dynasty_player_teams_on_team_id_and_lineup_id", :unique => true

  create_table "dynasty_positions", :force => true do |t|
    t.string  "name",             :limit => 32
    t.string  "abbreviation",     :limit => 5
    t.string  "designation",      :limit => 1,  :null => false
    t.integer "sort_order"
    t.integer "flex_position_id"
  end

  add_index "dynasty_positions", ["abbreviation", "id", "designation", "name", "sort_order"], :name => "index_dynasty_positions_on_abbr_id_des_name_sort"
  add_index "dynasty_positions", ["designation", "id"], :name => "index_dynasty_positions_on_flex_and_designation_and_id"
  add_index "dynasty_positions", ["flex_position_id"], :name => "index_dynasty_positions_on_flex_position_id"
  add_index "dynasty_positions", ["id", "abbreviation"], :name => "index_dynasty_positions_on_id_and_abbreviation"
  add_index "dynasty_positions", ["name"], :name => "index_dynasty_positions_on_name"
  add_index "dynasty_positions", ["sort_order", "id", "designation", "abbreviation", "name"], :name => "index_dynasty_positions_on_sort_id_des_abbr_name"
  add_index "dynasty_positions", ["sort_order", "id"], :name => "index_dynasty_positions_on_sort_order_and_id"

  create_table "dynasty_seasons", :force => true do |t|
    t.string   "affiliation", :limit => 6,                    :null => false
    t.integer  "year",                                        :null => false
    t.integer  "weeks",                    :default => 0,     :null => false
    t.boolean  "current",                  :default => false, :null => false
    t.date     "start_date",                                  :null => false
    t.date     "end_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "dynasty_seasons", ["affiliation", "current", "weeks"], :name => "index_dynasty_seasons_on_affiliation_and_current_and_weeks"
  add_index "dynasty_seasons", ["affiliation", "year", "current"], :name => "index_dynasty_seasons_on_affiliation_and_year_and_current", :unique => true
  add_index "dynasty_seasons", ["end_date", "affiliation", "current"], :name => "index_dynasty_seasons_on_end_date_and_affiliation_and_current"
  add_index "dynasty_seasons", ["start_date", "affiliation", "current"], :name => "index_dynasty_seasons_on_start_date_and_affiliation_and_current"

  create_table "dynasty_team_favorites", :force => true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "sort_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dynasty_team_favorites", ["team_id", "player_id", "sort_order"], :name => "index_favorites_team_player_sort"

  create_table "dynasty_teams", :force => true do |t|
    t.integer "league_id"
    t.string  "name",           :limit => 50,                     :null => false
    t.integer "user_id",                                          :null => false
    t.boolean "is_online",                     :default => false, :null => false
    t.binary  "uuid",           :limit => 255
    t.string  "last_socket_id"
    t.integer "balance_cents",  :limit => 8,   :default => 0,     :null => false
    t.boolean "autopick",                      :default => false
    t.integer "waiver_order"
    t.integer "draft_order"
    t.string  "motto"
  end

  add_index "dynasty_teams", ["balance_cents"], :name => "index_dynasty_teams_on_balance_cents"
  add_index "dynasty_teams", ["league_id"], :name => "index_user_teams_league"
  add_index "dynasty_teams", ["user_id", "league_id"], :name => "index_dynasty_teams_on_user_id_and_league_id"
  add_index "dynasty_teams", ["user_id"], :name => "index_user_teams_user"
  add_index "dynasty_teams", ["uuid"], :name => "index_user_teams_on_uuid", :length => {"uuid"=>16}

  create_table "dynasty_trades", :force => true do |t|
    t.integer  "initial_team_id",     :null => false
    t.integer  "second_team_id",      :null => false
    t.boolean  "accepted"
    t.boolean  "open"
    t.datetime "offered_at"
    t.datetime "accepted_at"
    t.datetime "denied_at"
    t.integer  "offered_player_id"
    t.integer  "requested_player_id"
    t.integer  "offered_cash"
    t.integer  "requested_cash"
    t.string   "offered_picks"
    t.string   "requested_picks"
    t.text     "message"
  end

  create_table "dynasty_user_addresses", :force => true do |t|
    t.string  "street2", :limit => 64
    t.string  "city",    :limit => 50
    t.string  "zip",     :limit => 10
    t.string  "state",   :limit => 32
    t.string  "country", :limit => 64
    t.string  "street",  :limit => 128
    t.integer "user_id",                :null => false
  end

  create_table "dynasty_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.datetime "last_seen"
    t.string   "first_name",             :limit => 50,                  :null => false
    t.string   "phone",                  :limit => 32
    t.string   "last_name",              :limit => 50,                  :null => false
  end

  add_index "dynasty_users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "dynasty_users", ["first_name"], :name => "index_dynasty_users_on_name"

  create_table "dynasty_waiver_bids", :force => true do |t|
    t.integer  "waiver_id"
    t.integer  "team_id"
    t.integer  "bid_cents"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dynasty_waiver_bids", ["team_id", "waiver_id"], :name => "index_dynasty_waiver_bids_on_teams"

  create_table "dynasty_waivers", :force => true do |t|
    t.integer  "player_team_id"
    t.integer  "team_id"
    t.datetime "end_datetime"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "dynasty_waivers", ["end_datetime"], :name => "index_dynasty_waivers_on_end_datetime"
  add_index "dynasty_waivers", ["player_team_id", "team_id"], :name => "index_dynasty_waiver_wires_on_teams"

  create_table "event_action_fouls", :force => true do |t|
    t.integer "event_state_id",                :null => false
    t.string  "foul_name",      :limit => 100
    t.string  "foul_result",    :limit => 100
    t.string  "foul_type",      :limit => 100
    t.string  "fouler_id",      :limit => 100
    t.string  "recipient_type", :limit => 100
    t.integer "recipient_id"
    t.string  "comment",        :limit => 512
  end

  add_index "event_action_fouls", ["event_state_id"], :name => "FK_event_states_event_action_fouls"

  create_table "event_action_participants", :force => true do |t|
    t.integer "event_state_id",                      :null => false
    t.integer "event_action_play_id",                :null => false
    t.integer "person_id",                           :null => false
    t.string  "participant_role",     :limit => 100
  end

  add_index "event_action_participants", ["event_action_play_id"], :name => "FK_event_action_plays_event_action_participants"
  add_index "event_action_participants", ["event_state_id"], :name => "FK_event_states_event_action_participants"
  add_index "event_action_participants", ["person_id"], :name => "FK_persons_event_action_participants"

  create_table "event_action_penalties", :force => true do |t|
    t.integer "event_state_id",                :null => false
    t.string  "penalty_type",   :limit => 100
    t.string  "penalty_level",  :limit => 100
    t.string  "caution_level",  :limit => 100
    t.string  "recipient_type", :limit => 100
    t.integer "recipient_id"
    t.string  "comment",        :limit => 512
  end

  add_index "event_action_penalties", ["event_state_id"], :name => "FK_event_states_event_action_penalties"

  create_table "event_action_plays", :force => true do |t|
    t.integer "event_state_id",                    :null => false
    t.string  "play_type",          :limit => 100
    t.string  "score_attempt_type", :limit => 100
    t.string  "play_result",        :limit => 100
    t.string  "comment",            :limit => 512
  end

  add_index "event_action_plays", ["event_state_id"], :name => "FK_event_states_event_action_plays"

  create_table "event_action_substitutions", :force => true do |t|
    t.integer "event_state_id",                              :null => false
    t.integer "person_original_id",                          :null => false
    t.integer "person_original_position_id",                 :null => false
    t.integer "person_replacing_id",                         :null => false
    t.integer "person_replacing_position_id",                :null => false
    t.string  "substitution_reason",          :limit => 100
    t.string  "comment",                      :limit => 512
  end

  add_index "event_action_substitutions", ["event_state_id"], :name => "FK_event_states_event_action_substitutions"
  add_index "event_action_substitutions", ["person_original_id"], :name => "FK_persons_event_action_substitutions"
  add_index "event_action_substitutions", ["person_original_position_id"], :name => "FK_positions_event_action_substitutions"
  add_index "event_action_substitutions", ["person_replacing_id"], :name => "FK_persons_event_action_substitutions1"
  add_index "event_action_substitutions", ["person_replacing_position_id"], :name => "FK_positions_event_action_substitutions1"

  create_table "event_states", :force => true do |t|
    t.integer "event_id",                              :null => false
    t.integer "current_state"
    t.integer "sequence_number"
    t.string  "period_value",           :limit => 100
    t.string  "period_time_elapsed",    :limit => 100
    t.string  "period_time_remaining",  :limit => 100
    t.string  "minutes_elapsed",        :limit => 100
    t.string  "period_minutes_elapsed", :limit => 100
    t.string  "context",                :limit => 40
    t.integer "document_id"
  end

  add_index "event_states", ["context"], :name => "IDX_event_states_context"
  add_index "event_states", ["event_id"], :name => "FK_events_event_states"
  add_index "event_states", ["sequence_number"], :name => "IDX_event_states_seq_num"

  create_table "events", :force => true do |t|
    t.string   "event_key",             :limit => 100, :null => false
    t.integer  "publisher_id",                         :null => false
    t.datetime "start_date_time"
    t.integer  "site_id"
    t.string   "site_alignment",        :limit => 100
    t.string   "event_status",          :limit => 100
    t.string   "duration",              :limit => 100
    t.string   "attendance",            :limit => 100
    t.datetime "last_update"
    t.string   "event_number",          :limit => 32
    t.string   "round_number",          :limit => 32
    t.string   "time_certainty",        :limit => 100
    t.string   "broadcast_listing"
    t.datetime "start_date_time_local"
    t.string   "medal_event",           :limit => 100
    t.string   "series_index",          :limit => 40
  end

  add_index "events", ["event_key"], :name => "IDX_events_1"
  add_index "events", ["publisher_id"], :name => "IDX_FK_eve_pub_id__pub_id"
  add_index "events", ["site_id"], :name => "IDX_FK_eve_sit_id__sit_id"

  create_table "events_documents", :id => false, :force => true do |t|
    t.integer "event_id",    :null => false
    t.integer "document_id", :null => false
  end

  add_index "events_documents", ["document_id"], :name => "FK_eve_doc_doc_id__doc_id"
  add_index "events_documents", ["event_id"], :name => "FK_eve_doc_eve_id__eve_id"

  create_table "events_media", :id => false, :force => true do |t|
    t.integer "event_id", :null => false
    t.integer "media_id", :null => false
  end

  add_index "events_media", ["event_id"], :name => "FK_eve_med_eve_id__eve_id"
  add_index "events_media", ["media_id"], :name => "FK_eve_med_med_id__med_id"

  create_table "events_sub_seasons", :id => false, :force => true do |t|
    t.integer "event_id",      :null => false
    t.integer "sub_season_id", :null => false
  end

  add_index "events_sub_seasons", ["sub_season_id"], :name => "FK_eve_sub_sea_sub_sea_id__sub_sea_id"

  create_table "fed_accounts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ice_hockey_action_participants", :force => true do |t|
    t.integer "team_id",                                  :null => false
    t.integer "ice_hockey_action_play_id",                :null => false
    t.integer "person_id",                                :null => false
    t.string  "participant_role",          :limit => 100
    t.integer "point_credit"
    t.integer "goals_cumulative"
    t.integer "assists_cumulative"
  end

  add_index "ice_hockey_action_participants", ["ice_hockey_action_play_id"], :name => "FK_ice_hockey_action_plays_ice_hockey_action_participants"
  add_index "ice_hockey_action_participants", ["person_id"], :name => "FK_persons_ice_hockey_action_participants"
  add_index "ice_hockey_action_participants", ["team_id"], :name => "FK_ice_hockey_action_participants_team_id_teams_id"

  create_table "ice_hockey_action_plays", :force => true do |t|
    t.integer "ice_hockey_event_state_id",                 :null => false
    t.string  "play_key",                  :limit => 100
    t.string  "play_type",                 :limit => 100
    t.string  "score_attempt_type",        :limit => 100
    t.string  "play_result",               :limit => 100
    t.string  "penalty_type",              :limit => 100
    t.string  "penalty_length",            :limit => 100
    t.string  "penalty_code",              :limit => 100
    t.string  "recipient_type",            :limit => 100
    t.integer "team_id"
    t.string  "strength",                  :limit => 100
    t.integer "shootout_shot_order"
    t.integer "goal_order"
    t.string  "shot_type",                 :limit => 100
    t.string  "shot_distance",             :limit => 100
    t.string  "goal_zone",                 :limit => 100
    t.string  "penalty_time_remaining",    :limit => 40
    t.string  "location",                  :limit => 40
    t.string  "zone",                      :limit => 40
    t.string  "comment",                   :limit => 1024
  end

  add_index "ice_hockey_action_plays", ["ice_hockey_event_state_id"], :name => "FK_ice_hockey_event_states_ice_hockey_action_plays"

  create_table "ice_hockey_defensive_stats", :force => true do |t|
    t.string  "goals_power_play_allowed",   :limit => 100
    t.string  "goals_penalty_shot_allowed", :limit => 100
    t.string  "goals_empty_net_allowed",    :limit => 100
    t.string  "goals_against_average",      :limit => 100
    t.string  "goals_short_handed_allowed", :limit => 100
    t.string  "goals_shootout_allowed",     :limit => 100
    t.string  "shots_power_play_allowed",   :limit => 100
    t.string  "shots_penalty_shot_allowed", :limit => 100
    t.string  "shots_blocked",              :limit => 100
    t.string  "saves",                      :limit => 100
    t.string  "save_percentage",            :limit => 100
    t.string  "penalty_killing_amount",     :limit => 100
    t.string  "penalty_killing_percentage", :limit => 100
    t.string  "takeaways",                  :limit => 100
    t.string  "shutouts",                   :limit => 100
    t.string  "minutes_penalty_killing",    :limit => 100
    t.string  "hits",                       :limit => 100
    t.string  "shots_shootout_allowed",     :limit => 100
    t.integer "goaltender_wins"
    t.integer "goaltender_losses"
    t.integer "goaltender_ties"
    t.integer "goals_allowed"
    t.integer "shots_allowed"
    t.integer "player_count"
    t.integer "player_count_opposing"
    t.integer "goaltender_wins_overtime"
    t.integer "goaltender_losses_overtime"
    t.integer "goals_overtime_allowed"
  end

  create_table "ice_hockey_event_states", :force => true do |t|
    t.integer "power_play_team_id"
    t.integer "event_id",                                   :null => false
    t.integer "current_state",               :limit => 1
    t.string  "period_value",                :limit => 100
    t.string  "period_time_elapsed",         :limit => 100
    t.string  "period_time_remaining",       :limit => 100
    t.string  "record_type",                 :limit => 40
    t.integer "power_play_player_advantage"
    t.integer "score_team"
    t.integer "score_team_opposing"
    t.integer "score_team_home"
    t.integer "score_team_away"
    t.string  "action_key",                  :limit => 100
    t.string  "sequence_number",             :limit => 100
    t.string  "context",                     :limit => 40
    t.integer "document_id"
  end

  add_index "ice_hockey_event_states", ["context"], :name => "IDX_ice_hockey_event_states_context"
  add_index "ice_hockey_event_states", ["event_id"], :name => "FK_ice_hoc_eve_sta_eve_id__eve_id"
  add_index "ice_hockey_event_states", ["power_play_team_id"], :name => "FK_hockey_event_states_power_play_team_id_teams_id"
  add_index "ice_hockey_event_states", ["sequence_number"], :name => "IDX_ice_hockey_event_states_seq_num"

  create_table "ice_hockey_faceoff_stats", :force => true do |t|
    t.integer "player_count"
    t.integer "player_count_opposing"
    t.integer "faceoff_wins"
    t.integer "faceoff_losses"
    t.decimal "faceoff_win_percentage",                 :precision => 5, :scale => 2
    t.integer "faceoffs_power_play_wins"
    t.integer "faceoffs_power_play_losses"
    t.decimal "faceoffs_power_play_win_percentage",     :precision => 5, :scale => 2
    t.integer "faceoffs_short_handed_wins"
    t.integer "faceoffs_short_handed_losses"
    t.decimal "faceoffs_short_handed_win_percentage",   :precision => 5, :scale => 2
    t.integer "faceoffs_even_strength_wins"
    t.integer "faceoffs_even_strength_losses"
    t.decimal "faceoffs_even_strength_win_percentage",  :precision => 5, :scale => 2
    t.integer "faceoffs_offensive_zone_wins"
    t.integer "faceoffs_offensive_zone_losses"
    t.decimal "faceoffs_offensive_zone_win_percentage", :precision => 5, :scale => 2
    t.integer "faceoffs_defensive_zone_wins"
    t.integer "faceoffs_defensive_zone_losses"
    t.decimal "faceoffs_defensive_zone_win_percentage", :precision => 5, :scale => 2
    t.integer "faceoffs_neutral_zone_wins"
    t.integer "faceoffs_neutral_zone_losses"
    t.decimal "faceoffs_neutral_zone_win_percentage",   :precision => 5, :scale => 2
  end

  create_table "ice_hockey_offensive_stats", :force => true do |t|
    t.string  "giveaways",                     :limit => 100
    t.integer "goals"
    t.string  "goals_game_winning",            :limit => 100
    t.string  "goals_game_tying",              :limit => 100
    t.string  "goals_power_play",              :limit => 100
    t.string  "goals_short_handed",            :limit => 100
    t.string  "goals_even_strength",           :limit => 100
    t.string  "goals_empty_net",               :limit => 100
    t.string  "goals_overtime",                :limit => 100
    t.string  "goals_shootout",                :limit => 100
    t.string  "goals_penalty_shot",            :limit => 100
    t.string  "assists",                       :limit => 100
    t.integer "shots"
    t.string  "shots_penalty_shot_taken",      :limit => 100
    t.string  "shots_penalty_shot_missed",     :limit => 100
    t.string  "shots_penalty_shot_percentage", :limit => 100
    t.integer "shots_missed"
    t.integer "shots_blocked"
    t.integer "shots_power_play"
    t.integer "shots_short_handed"
    t.integer "shots_even_strength"
    t.string  "points",                        :limit => 100
    t.string  "power_play_amount",             :limit => 100
    t.string  "power_play_percentage",         :limit => 100
    t.string  "minutes_power_play",            :limit => 100
    t.string  "faceoff_wins",                  :limit => 100
    t.string  "faceoff_losses",                :limit => 100
    t.string  "faceoff_win_percentage",        :limit => 100
    t.string  "scoring_chances",               :limit => 100
    t.integer "player_count"
    t.integer "player_count_opposing"
    t.integer "assists_game_winning"
    t.integer "assists_overtime"
    t.integer "assists_power_play"
    t.integer "assists_short_handed"
  end

  create_table "ice_hockey_player_stats", :force => true do |t|
    t.string "plus_minus", :limit => 100
  end

  create_table "ice_hockey_time_on_ice_stats", :force => true do |t|
    t.integer "player_count"
    t.integer "player_count_opposing"
    t.integer "shifts"
    t.string  "time_total",                   :limit => 40
    t.string  "time_power_play",              :limit => 40
    t.string  "time_short_handed",            :limit => 40
    t.string  "time_even_strength",           :limit => 40
    t.string  "time_empty_net",               :limit => 40
    t.string  "time_power_play_empty_net",    :limit => 40
    t.string  "time_short_handed_empty_net",  :limit => 40
    t.string  "time_even_strength_empty_net", :limit => 40
    t.string  "time_average_per_shift",       :limit => 40
  end

  create_table "injury_phases", :force => true do |t|
    t.integer  "person_id",                      :null => false
    t.string   "injury_status",   :limit => 100
    t.string   "injury_type",     :limit => 100
    t.string   "injury_comment",  :limit => 100
    t.string   "disabled_list",   :limit => 100
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.integer  "season_id"
    t.string   "phase_type",      :limit => 100
    t.string   "injury_side",     :limit => 100
  end

  add_index "injury_phases", ["end_date_time"], :name => "IDX_injury_phases_4"
  add_index "injury_phases", ["injury_status"], :name => "IDX_injury_phases_2"
  add_index "injury_phases", ["person_id"], :name => "IDX_FK_inj_pha_per_id__per_id"
  add_index "injury_phases", ["season_id"], :name => "IDX_FK_inj_pha_sea_id__sea_id"
  add_index "injury_phases", ["start_date_time"], :name => "IDX_injury_phases_3"

  create_table "key_aliases", :force => true do |t|
    t.integer "key_id",      :null => false
    t.integer "key_root_id", :null => false
  end

  add_index "key_aliases", ["key_id"], :name => "IDX_key_aliases_2"
  add_index "key_aliases", ["key_root_id"], :name => "FK_key_roots_key_aliases"

  create_table "key_roots", :force => true do |t|
    t.string "key_type", :limit => 100
  end

  add_index "key_roots", ["key_type"], :name => "IDX_key_aliases_1"

  create_table "latest_revisions", :force => true do |t|
    t.string  "revision_id",        :null => false
    t.integer "latest_document_id", :null => false
  end

  add_index "latest_revisions", ["latest_document_id"], :name => "IDX_FK_lat_rev_lat_doc_id__doc_id"
  add_index "latest_revisions", ["revision_id"], :name => "IDX_latest_revisions_1"

  create_table "ledgers", :force => true do |t|
    t.text     "description"
    t.integer  "amount"
    t.integer  "account"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lineup_flex_players", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0, :null => false
    t.string  "full_name",       :limit => 100
    t.string  "position",        :limit => 5
    t.integer "lineup_id"
    t.string  "lineup_position", :limit => 5
  end

  create_table "locations", :force => true do |t|
    t.string "city",         :limit => 100
    t.string "state",        :limit => 100
    t.string "area",         :limit => 100
    t.string "country",      :limit => 100
    t.string "timezone",     :limit => 100
    t.string "latitude",     :limit => 100
    t.string "longitude",    :limit => 100
    t.string "country_code", :limit => 100
  end

  add_index "locations", ["country_code"], :name => "IDX_locations_1"

  create_table "media", :force => true do |t|
    t.integer  "object_id"
    t.integer  "source_id"
    t.integer  "revision_id"
    t.string   "media_type",           :limit => 100
    t.integer  "publisher_id",                        :null => false
    t.string   "date_time",            :limit => 100
    t.integer  "credit_id",                           :null => false
    t.datetime "db_loading_date_time"
    t.integer  "creation_location_id",                :null => false
  end

  add_index "media", ["creation_location_id"], :name => "FK_med_cre_loc_id__loc_id"
  add_index "media", ["credit_id"], :name => "FK_med_cre_id__per_id"
  add_index "media", ["publisher_id"], :name => "FK_med_pub_id__pub_id"

  create_table "media_captions", :force => true do |t|
    t.integer "media_id",                         :null => false
    t.string  "caption_type",      :limit => 100
    t.string  "caption",           :limit => 100
    t.integer "caption_author_id",                :null => false
    t.string  "language",          :limit => 100
    t.string  "caption_size",      :limit => 100
  end

  add_index "media_captions", ["caption_author_id"], :name => "FK_med_cap_cap_aut_id__per_id"
  add_index "media_captions", ["media_id"], :name => "FK_med_cap_med_id__med_id"

  create_table "media_contents", :force => true do |t|
    t.integer "media_id",                  :null => false
    t.string  "object",     :limit => 100
    t.string  "format",     :limit => 100
    t.string  "mime_type",  :limit => 100
    t.string  "height",     :limit => 100
    t.string  "width",      :limit => 100
    t.string  "duration",   :limit => 100
    t.string  "file_size",  :limit => 100
    t.string  "resolution", :limit => 100
  end

  add_index "media_contents", ["media_id"], :name => "FK_med_con_med_id__med_id"

  create_table "media_keywords", :force => true do |t|
    t.string  "keyword",  :limit => 100
    t.integer "media_id",                :null => false
  end

  add_index "media_keywords", ["media_id"], :name => "FK_med_key_med_id__med_id"

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "motor_racing_event_states", :force => true do |t|
    t.integer "event_id",                       :null => false
    t.integer "current_state",   :limit => 1
    t.integer "sequence_number"
    t.string  "lap",             :limit => 100
    t.string  "laps_remaining",  :limit => 100
    t.string  "time_elapsed",    :limit => 100
    t.string  "flag_state",      :limit => 100
    t.string  "context",         :limit => 40
    t.integer "document_id"
  end

  add_index "motor_racing_event_states", ["context"], :name => "IDX_motor_racing_event_states_context"
  add_index "motor_racing_event_states", ["event_id"], :name => "IDX_FK_events_motor_racing_event_states"
  add_index "motor_racing_event_states", ["sequence_number"], :name => "IDX_motor_racing_event_states_seq_num"

  create_table "motor_racing_event_stats", :force => true do |t|
    t.decimal "speed_average",                      :precision => 6, :scale => 3
    t.string  "speed_units",          :limit => 40
    t.decimal "margin_of_victory",                  :precision => 6, :scale => 3
    t.integer "caution_flags"
    t.integer "caution_flags_laps"
    t.integer "lead_changes"
    t.integer "lead_changes_drivers"
    t.integer "laps_total"
  end

  create_table "motor_racing_qualifying_stats", :force => true do |t|
    t.string "grid",                   :limit => 100
    t.string "pole_position",          :limit => 100
    t.string "pole_wins",              :limit => 100
    t.string "qualifying_speed",       :limit => 100
    t.string "qualifying_speed_units", :limit => 100
    t.string "qualifying_time",        :limit => 100
    t.string "qualifying_position",    :limit => 100
  end

  create_table "motor_racing_race_stats", :force => true do |t|
    t.string "time_behind_leader",  :limit => 100
    t.string "laps_behind_leader",  :limit => 100
    t.string "time_ahead_follower", :limit => 100
    t.string "laps_ahead_follower", :limit => 100
    t.string "time",                :limit => 100
    t.string "points",              :limit => 100
    t.string "points_rookie",       :limit => 100
    t.string "bonus",               :limit => 100
    t.string "laps_completed",      :limit => 100
    t.string "laps_leading_total",  :limit => 100
    t.string "distance_leading",    :limit => 100
    t.string "distance_completed",  :limit => 100
    t.string "distance_units",      :limit => 40
    t.string "speed_average",       :limit => 40
    t.string "speed_units",         :limit => 40
    t.string "status",              :limit => 40
    t.string "finishes_top_5",      :limit => 40
    t.string "finishes_top_10",     :limit => 40
    t.string "starts",              :limit => 40
    t.string "finishes",            :limit => 40
    t.string "non_finishes",        :limit => 40
    t.string "wins",                :limit => 40
    t.string "races_leading",       :limit => 40
    t.string "money",               :limit => 40
    t.string "money_units",         :limit => 40
    t.string "leads_total",         :limit => 40
  end

  create_table "outcome_totals", :force => true do |t|
    t.integer  "standing_subgroup_id",                 :null => false
    t.string   "outcome_holder_type",   :limit => 100
    t.integer  "outcome_holder_id"
    t.string   "rank",                  :limit => 100
    t.string   "wins",                  :limit => 100
    t.string   "losses",                :limit => 100
    t.string   "ties",                  :limit => 100
    t.integer  "wins_overtime"
    t.integer  "losses_overtime"
    t.string   "undecideds",            :limit => 100
    t.string   "winning_percentage",    :limit => 100
    t.string   "points_scored_for",     :limit => 100
    t.string   "points_scored_against", :limit => 100
    t.string   "points_difference",     :limit => 100
    t.string   "standing_points",       :limit => 100
    t.string   "streak_type",           :limit => 100
    t.string   "streak_duration",       :limit => 100
    t.string   "streak_total",          :limit => 100
    t.datetime "streak_start"
    t.datetime "streak_end"
    t.integer  "events_played"
    t.string   "games_back",            :limit => 100
    t.string   "result_effect",         :limit => 100
    t.string   "sets_against",          :limit => 100
    t.string   "sets_for",              :limit => 100
  end

  add_index "outcome_totals", ["standing_subgroup_id"], :name => "FK_out_tot_sta_sub_id__sta_sub_id"

  create_table "participants_events", :force => true do |t|
    t.string  "participant_type", :limit => 100, :null => false
    t.integer "participant_id",                  :null => false
    t.integer "event_id",                        :null => false
    t.string  "alignment",        :limit => 100
    t.string  "score",            :limit => 100
    t.string  "event_outcome",    :limit => 100
    t.integer "rank"
    t.string  "result_effect",    :limit => 100
    t.integer "score_attempts"
    t.string  "sort_order",       :limit => 100
    t.string  "score_type",       :limit => 100
  end

  add_index "participants_events", ["alignment"], :name => "IDX_participants_events_3"
  add_index "participants_events", ["event_id"], :name => "IDX_FK_par_eve_eve_id__eve_id"
  add_index "participants_events", ["event_outcome"], :name => "IDX_participants_events_4"
  add_index "participants_events", ["participant_id"], :name => "IDX_participants_events_2"
  add_index "participants_events", ["participant_type"], :name => "IDX_participants_events_1"

  create_table "penalty_stats", :force => true do |t|
    t.integer "count"
    t.string  "type",  :limit => 100
    t.integer "value"
  end

  create_table "periods", :force => true do |t|
    t.integer "participant_event_id",                :null => false
    t.string  "period_value",         :limit => 100
    t.string  "score",                :limit => 100
    t.integer "score_attempts"
    t.string  "rank",                 :limit => 100
    t.string  "sub_score_key",        :limit => 100
    t.string  "sub_score_type",       :limit => 100
    t.string  "sub_score_name",       :limit => 100
  end

  add_index "periods", ["participant_event_id"], :name => "IDX_FK_per_par_eve_id__par_eve_id"

  create_table "person_event_metadata", :force => true do |t|
    t.integer "person_id",                           :null => false
    t.integer "event_id",                            :null => false
    t.string  "status",               :limit => 100
    t.string  "health",               :limit => 100
    t.string  "weight",               :limit => 100
    t.integer "role_id"
    t.integer "position_id"
    t.integer "team_id"
    t.integer "lineup_slot"
    t.integer "lineup_slot_sequence"
  end

  add_index "person_event_metadata", ["event_id"], :name => "IDX_FK_per_eve_met_eve_id__eve_id"
  add_index "person_event_metadata", ["person_id"], :name => "IDX_FK_per_eve_met_per_id__per_id"
  add_index "person_event_metadata", ["position_id"], :name => "IDX_FK_per_eve_met_pos_id__pos_id"
  add_index "person_event_metadata", ["role_id"], :name => "IDX_FK_per_eve_met_rol_id__rol_id"
  add_index "person_event_metadata", ["status"], :name => "IDX_person_event_metadata_1"
  add_index "person_event_metadata", ["team_id"], :name => "IDX_FK_teams_person_event_metadata"

  create_table "person_phases", :force => true do |t|
    t.integer  "person_id",                             :null => false
    t.string   "membership_type",        :limit => 40,  :null => false
    t.integer  "membership_id",                         :null => false
    t.integer  "role_id"
    t.string   "role_status",            :limit => 40
    t.string   "phase_status",           :limit => 40
    t.string   "uniform_number",         :limit => 20
    t.integer  "regular_position_id"
    t.string   "regular_position_depth", :limit => 40
    t.string   "height",                 :limit => 100
    t.string   "weight",                 :limit => 100
    t.datetime "start_date_time"
    t.integer  "start_season_id"
    t.datetime "end_date_time"
    t.integer  "end_season_id"
    t.string   "entry_reason",           :limit => 40
    t.string   "exit_reason",            :limit => 40
    t.integer  "selection_level"
    t.integer  "selection_sublevel"
    t.integer  "selection_overall"
    t.string   "duration",               :limit => 32
    t.string   "phase_type",             :limit => 40
    t.string   "subphase_type",          :limit => 40
  end

  add_index "person_phases", ["end_season_id"], :name => "FK_per_pha_end_sea_id__sea_id"
  add_index "person_phases", ["membership_id"], :name => "IDX_person_phases_2"
  add_index "person_phases", ["membership_type"], :name => "IDX_person_phases_1"
  add_index "person_phases", ["person_id"], :name => "IDX_FK_per_pha_per_id__per_id"
  add_index "person_phases", ["phase_status"], :name => "IDX_person_phases_3"
  add_index "person_phases", ["regular_position_id"], :name => "IDX_FK_per_pha_reg_pos_id__pos_id"
  add_index "person_phases", ["role_id"], :name => "FK_per_pha_rol_id__rol_id"
  add_index "person_phases", ["start_season_id"], :name => "FK_per_pha_sta_sea_id__sea_id"

  create_table "persons", :force => true do |t|
    t.string  "person_key",                :limit => 100, :null => false
    t.integer "publisher_id",                             :null => false
    t.string  "gender",                    :limit => 20
    t.string  "birth_date",                :limit => 30
    t.string  "death_date",                :limit => 30
    t.integer "final_resting_location_id"
    t.integer "birth_location_id"
    t.integer "hometown_location_id"
    t.integer "residence_location_id"
    t.integer "death_location_id"
  end

  add_index "persons", ["birth_location_id"], :name => "FK_per_bir_loc_id__loc_id"
  add_index "persons", ["death_location_id"], :name => "FK_per_dea_loc_id__loc_id"
  add_index "persons", ["final_resting_location_id"], :name => "FK_persons_final_resting_location_id_locations_id"
  add_index "persons", ["hometown_location_id"], :name => "FK_per_hom_loc_id__loc_id"
  add_index "persons", ["person_key"], :name => "IDX_persons_1"
  add_index "persons", ["publisher_id"], :name => "IDX_FK_per_pub_id__pub_id"
  add_index "persons", ["residence_location_id"], :name => "FK_per_res_loc_id__loc_id"

  create_table "persons_documents", :id => false, :force => true do |t|
    t.integer "person_id",   :null => false
    t.integer "document_id", :null => false
  end

  add_index "persons_documents", ["document_id"], :name => "FK_per_doc_doc_id__doc_id"
  add_index "persons_documents", ["person_id"], :name => "FK_per_doc_per_id__per_id"

  create_table "persons_media", :id => false, :force => true do |t|
    t.integer "person_id", :null => false
    t.integer "media_id",  :null => false
  end

  add_index "persons_media", ["media_id"], :name => "FK_per_med_med_id__med_id"
  add_index "persons_media", ["person_id"], :name => "FK_per_med_per_id__per_id"

  create_table "photos", :force => true do |t|
    t.string   "url"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", :force => true do |t|
    t.integer "affiliation_id",                :null => false
    t.string  "abbreviation",   :limit => 100, :null => false
  end

  add_index "positions", ["abbreviation"], :name => "IDX_positions_1"
  add_index "positions", ["affiliation_id"], :name => "IDX_FK_pos_aff_id__aff_id"

  create_table "publishers", :force => true do |t|
    t.string "publisher_key",  :limit => 100, :null => false
    t.string "publisher_name", :limit => 100
  end

  add_index "publishers", ["publisher_key"], :name => "IDX_publishers_1"

  create_table "rankings", :force => true do |t|
    t.integer "document_fixture_id"
    t.string  "participant_type",       :limit => 100
    t.integer "participant_id"
    t.string  "issuer",                 :limit => 100
    t.string  "ranking_type",           :limit => 100
    t.string  "ranking_value",          :limit => 100
    t.string  "ranking_value_previous", :limit => 100
    t.string  "date_coverage_type",     :limit => 100
    t.integer "date_coverage_id"
  end

  create_table "records", :force => true do |t|
    t.string  "participant_type",   :limit => 100
    t.integer "participant_id"
    t.string  "record_type",        :limit => 100
    t.string  "record_label",       :limit => 100
    t.string  "record_value",       :limit => 100
    t.string  "previous_value",     :limit => 100
    t.string  "date_coverage_type", :limit => 100
    t.integer "date_coverage_id"
    t.string  "comment",            :limit => 512
  end

  create_table "roles", :force => true do |t|
    t.string   "name",          :limit => 32
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "schedules", :force => true do |t|
    t.integer  "league_id"
    t.integer  "team_id"
    t.integer  "opponent_id"
    t.integer  "week"
    t.integer  "outcome"
    t.integer  "team_score"
    t.integer  "opponent_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", :force => true do |t|
    t.integer  "season_key",      :null => false
    t.integer  "publisher_id",    :null => false
    t.integer  "league_id"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
  end

  add_index "seasons", ["league_id"], :name => "IDX_FK_sea_lea_id__aff_id"
  add_index "seasons", ["publisher_id"], :name => "IDX_FK_sea_pub_id__pub_id"
  add_index "seasons", ["season_key"], :name => "IDX_seasons_1"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.string  "site_key",     :limit => 128, :null => false
    t.integer "publisher_id",                :null => false
    t.integer "location_id"
  end

  add_index "sites", ["location_id"], :name => "IDX_FK_sit_loc_id__loc_id"
  add_index "sites", ["publisher_id"], :name => "IDX_FK_sit_pub_id__pub_id"
  add_index "sites", ["site_key"], :name => "IDX_sites_1"

  create_table "soccer_action_fouls", :force => true do |t|
    t.integer "soccer_event_state_id",                :null => false
    t.string  "foul_name",             :limit => 100
    t.string  "foul_result",           :limit => 100
    t.string  "foul_type",             :limit => 100
    t.string  "fouler_id",             :limit => 100
    t.string  "recipient_type",        :limit => 100
    t.integer "recipient_id",                         :null => false
    t.string  "comment",               :limit => 512
  end

  add_index "soccer_action_fouls", ["recipient_id"], :name => "FK_persons_soccer_action_fouls"
  add_index "soccer_action_fouls", ["soccer_event_state_id"], :name => "FK_soccer_event_states_soccer_action_fouls"

  create_table "soccer_action_participants", :force => true do |t|
    t.integer "soccer_action_play_id",                :null => false
    t.integer "person_id",                            :null => false
    t.string  "participant_role",      :limit => 100
  end

  add_index "soccer_action_participants", ["person_id"], :name => "FK_persons_soccer_action_participants"
  add_index "soccer_action_participants", ["soccer_action_play_id"], :name => "FK_soccer_action_plays_soccer_action_participants"

  create_table "soccer_action_penalties", :force => true do |t|
    t.integer "soccer_event_state_id",                :null => false
    t.string  "penalty_type",          :limit => 100
    t.string  "penalty_level",         :limit => 100
    t.string  "caution_value",         :limit => 100
    t.string  "recipient_type",        :limit => 100
    t.integer "recipient_id",                         :null => false
    t.string  "comment",               :limit => 512
  end

  add_index "soccer_action_penalties", ["recipient_id"], :name => "FK_persons_soccer_action_penalties"
  add_index "soccer_action_penalties", ["soccer_event_state_id"], :name => "FK_soccer_event_states_soccer_action_penalties"

  create_table "soccer_action_plays", :force => true do |t|
    t.integer "soccer_event_state_id",                :null => false
    t.string  "play_type",             :limit => 100
    t.string  "score_attempt_type",    :limit => 100
    t.string  "play_result",           :limit => 100
    t.string  "comment",               :limit => 100
  end

  add_index "soccer_action_plays", ["soccer_event_state_id"], :name => "FK_soccer_event_states_soccer_action_plays"

  create_table "soccer_action_substitutions", :force => true do |t|
    t.integer "soccer_event_state_id",                       :null => false
    t.string  "person_type",                  :limit => 100
    t.integer "person_original_id",                          :null => false
    t.integer "person_original_position_id"
    t.integer "person_replacing_id",                         :null => false
    t.integer "person_replacing_position_id"
    t.string  "substitution_reason",          :limit => 100
    t.string  "comment",                      :limit => 512
  end

  add_index "soccer_action_substitutions", ["person_original_id"], :name => "FK_persons_soccer_action_substitutions"
  add_index "soccer_action_substitutions", ["person_original_position_id"], :name => "FK_positions_soccer_action_substitutions"
  add_index "soccer_action_substitutions", ["person_replacing_id"], :name => "FK_persons_soccer_action_substitutions1"
  add_index "soccer_action_substitutions", ["person_replacing_position_id"], :name => "FK_positions_soccer_action_substitutions1"
  add_index "soccer_action_substitutions", ["soccer_event_state_id"], :name => "FK_soccer_event_states_soccer_action_substitutions"

  create_table "soccer_defensive_stats", :force => true do |t|
    t.string "shots_penalty_shot_allowed", :limit => 100
    t.string "goals_penalty_shot_allowed", :limit => 100
    t.string "goals_against_average",      :limit => 100
    t.string "goals_against_total",        :limit => 100
    t.string "saves",                      :limit => 100
    t.string "save_percentage",            :limit => 100
    t.string "catches_punches",            :limit => 100
    t.string "shots_on_goal_total",        :limit => 100
    t.string "shots_shootout_total",       :limit => 100
    t.string "shots_shootout_allowed",     :limit => 100
    t.string "shots_blocked",              :limit => 100
    t.string "shutouts",                   :limit => 100
  end

  create_table "soccer_event_states", :force => true do |t|
    t.integer "event_id",                             :null => false
    t.integer "current_state",         :limit => 1
    t.integer "sequence_number"
    t.string  "period_value",          :limit => 100
    t.string  "period_time_elapsed",   :limit => 100
    t.string  "period_time_remaining", :limit => 100
    t.string  "minutes_elapsed",       :limit => 100
    t.string  "period_minute_elapsed", :limit => 100
    t.string  "context",               :limit => 40
    t.integer "document_id"
  end

  add_index "soccer_event_states", ["context"], :name => "IDX_soccer_event_states_context"
  add_index "soccer_event_states", ["event_id"], :name => "IDX_FK_events_soccer_event_states"
  add_index "soccer_event_states", ["sequence_number"], :name => "IDX_soccer_event_states_seq_num"

  create_table "soccer_foul_stats", :force => true do |t|
    t.string "fouls_suffered",         :limit => 100
    t.string "fouls_commited",         :limit => 100
    t.string "cautions_total",         :limit => 100
    t.string "cautions_pending",       :limit => 100
    t.string "caution_points_total",   :limit => 100
    t.string "caution_points_pending", :limit => 100
    t.string "ejections_total",        :limit => 100
  end

  create_table "soccer_offensive_stats", :force => true do |t|
    t.string "goals_game_winning",            :limit => 100
    t.string "goals_game_tying",              :limit => 100
    t.string "goals_overtime",                :limit => 100
    t.string "goals_shootout",                :limit => 100
    t.string "goals_total",                   :limit => 100
    t.string "assists_game_winning",          :limit => 100
    t.string "assists_game_tying",            :limit => 100
    t.string "assists_overtime",              :limit => 100
    t.string "assists_total",                 :limit => 100
    t.string "points",                        :limit => 100
    t.string "shots_total",                   :limit => 100
    t.string "shots_on_goal_total",           :limit => 100
    t.string "shots_hit_frame",               :limit => 100
    t.string "shots_penalty_shot_taken",      :limit => 100
    t.string "shots_penalty_shot_scored",     :limit => 100
    t.string "shots_penalty_shot_missed",     :limit => 40
    t.string "shots_penalty_shot_percentage", :limit => 40
    t.string "shots_shootout_taken",          :limit => 40
    t.string "shots_shootout_scored",         :limit => 40
    t.string "shots_shootout_missed",         :limit => 40
    t.string "shots_shootout_percentage",     :limit => 40
    t.string "giveaways",                     :limit => 40
    t.string "offsides",                      :limit => 40
    t.string "corner_kicks",                  :limit => 40
    t.string "hat_tricks",                    :limit => 40
  end

  create_table "sports_property", :force => true do |t|
    t.string  "sports_property_type", :limit => 100
    t.integer "sports_property_id"
    t.string  "formal_name",          :limit => 100, :null => false
    t.string  "value"
  end

  create_table "standing_subgroups", :force => true do |t|
    t.integer "standing_id",                         :null => false
    t.integer "affiliation_id",                      :null => false
    t.string  "alignment_scope",      :limit => 100
    t.string  "competition_scope",    :limit => 100
    t.string  "competition_scope_id", :limit => 100
    t.string  "duration_scope",       :limit => 100
    t.string  "scoping_label",        :limit => 100
    t.string  "site_scope",           :limit => 100
  end

  add_index "standing_subgroups", ["affiliation_id"], :name => "FK_sta_sub_aff_id__aff_id"
  add_index "standing_subgroups", ["standing_id"], :name => "FK_sta_sub_sta_id__sta_id"

  create_table "standings", :force => true do |t|
    t.integer "affiliation_id",                :null => false
    t.string  "standing_type",  :limit => 100
    t.integer "sub_season_id",                 :null => false
    t.string  "last_updated",   :limit => 100
    t.string  "source",         :limit => 100
  end

  add_index "standings", ["affiliation_id"], :name => "FK_sta_aff_id__aff_id"
  add_index "standings", ["sub_season_id"], :name => "FK_sta_sub_sea_id__sub_sea_id"

  create_table "stats", :force => true do |t|
    t.string   "stat_repository_type", :limit => 100
    t.integer  "stat_repository_id",                  :null => false
    t.string   "stat_holder_type",     :limit => 100
    t.integer  "stat_holder_id"
    t.string   "stat_coverage_type",   :limit => 100
    t.integer  "stat_coverage_id"
    t.string   "stat_membership_type", :limit => 40
    t.integer  "stat_membership_id"
    t.string   "context",              :limit => 40,  :null => false
    t.string   "scope"
    t.datetime "start_date_time"
  end

  add_index "stats", ["context"], :name => "IDX_stats_7"
  add_index "stats", ["stat_coverage_id"], :name => "IDX_stats_6"
  add_index "stats", ["stat_coverage_type"], :name => "IDX_stats_5"
  add_index "stats", ["stat_holder_id"], :name => "IDX_stats_4"
  add_index "stats", ["stat_holder_type"], :name => "IDX_stats_3"
  add_index "stats", ["stat_repository_id"], :name => "IDX_stats_2"
  add_index "stats", ["stat_repository_type"], :name => "IDX_stats_1"

  create_table "sub_periods", :force => true do |t|
    t.integer "period_id",                       :null => false
    t.string  "sub_period_value", :limit => 100
    t.string  "score",            :limit => 100
    t.integer "score_attempts"
  end

  add_index "sub_periods", ["period_id"], :name => "IDX_FK_sub_per_per_id__per_id"

  create_table "sub_seasons", :force => true do |t|
    t.string   "sub_season_key",  :limit => 100, :null => false
    t.integer  "season_id",                      :null => false
    t.string   "sub_season_type", :limit => 100, :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
  end

  add_index "sub_seasons", ["season_id"], :name => "IDX_FK_sub_sea_sea_id__sea_id"
  add_index "sub_seasons", ["sub_season_key"], :name => "IDX_sub_seasons_1"
  add_index "sub_seasons", ["sub_season_type"], :name => "IDX_sub_seasons_2"

  create_table "team_phases", :force => true do |t|
    t.integer "team_id",                        :null => false
    t.integer "start_season_id"
    t.integer "end_season_id"
    t.integer "affiliation_id",                 :null => false
    t.string  "start_date_time", :limit => 100
    t.string  "end_date_time",   :limit => 100
    t.string  "phase_status",    :limit => 40
    t.integer "role_id"
  end

  add_index "team_phases", ["affiliation_id"], :name => "FK_tea_aff_pha_aff_id__aff_id"
  add_index "team_phases", ["end_season_id"], :name => "FK_tea_aff_pha_end_sea_id__sea_id"
  add_index "team_phases", ["role_id"], :name => "FK_tea_aff_pha_rol_id__rol_id"
  add_index "team_phases", ["start_season_id"], :name => "FK_tea_aff_pha_sta_sea_id__sea_id"
  add_index "team_phases", ["team_id"], :name => "FK_tea_aff_pha_tea_id__tea_id"

  create_table "teams", :force => true do |t|
    t.string  "team_key",     :limit => 100, :null => false
    t.integer "publisher_id",                :null => false
    t.integer "home_site_id"
  end

  add_index "teams", ["home_site_id"], :name => "FK_tea_hom_sit_id__sit_id"
  add_index "teams", ["publisher_id"], :name => "FK_tea_pub_id__pub_id"
  add_index "teams", ["team_key"], :name => "IDX_teams_team_key"

  create_table "teams_documents", :id => false, :force => true do |t|
    t.integer "team_id",     :null => false
    t.integer "document_id", :null => false
  end

  add_index "teams_documents", ["document_id"], :name => "FK_tea_doc_doc_id__doc_id"
  add_index "teams_documents", ["team_id"], :name => "FK_tea_doc_tea_id__tea_id"

  create_table "teams_media", :id => false, :force => true do |t|
    t.integer "team_id",  :null => false
    t.integer "media_id", :null => false
  end

  add_index "teams_media", ["media_id"], :name => "FK_tea_med_med_id__med_id"
  add_index "teams_media", ["team_id"], :name => "FK_tea_med_tea_id__tea_id"

  create_table "tennis_action_points", :force => true do |t|
    t.string "sub_period_id",   :limit => 100
    t.string "sequence_number", :limit => 100
    t.string "win_type",        :limit => 100
  end

  create_table "tennis_action_volleys", :force => true do |t|
    t.string  "sequence_number",         :limit => 100
    t.integer "tennis_action_points_id"
    t.string  "landing_location",        :limit => 100
    t.string  "swing_type",              :limit => 100
    t.string  "result",                  :limit => 100
    t.string  "spin_type",               :limit => 100
    t.string  "trajectory_details",      :limit => 100
  end

  create_table "tennis_event_states", :force => true do |t|
    t.integer "event_id",                          :null => false
    t.integer "current_state",      :limit => 1
    t.integer "sequence_number"
    t.string  "tennis_set",         :limit => 100
    t.string  "game",               :limit => 100
    t.integer "server_person_id"
    t.string  "server_score",       :limit => 100
    t.integer "receiver_person_id"
    t.string  "receiver_score",     :limit => 100
    t.string  "service_number",     :limit => 100
    t.string  "context",            :limit => 40
    t.integer "document_id"
  end

  add_index "tennis_event_states", ["context"], :name => "IDX_tennis_event_states_context"
  add_index "tennis_event_states", ["event_id"], :name => "IDX_FK_events_tennis_event_states"
  add_index "tennis_event_states", ["sequence_number"], :name => "IDX_tennis_event_states_seq_num"

  create_table "tennis_player_stats", :force => true do |t|
    t.integer "net_points_won"
    t.integer "net_points_played"
    t.integer "points_won"
    t.integer "winners"
    t.integer "unforced_errors"
    t.integer "winners_forehand"
    t.integer "winners_backhand"
    t.integer "winners_volley"
  end

  create_table "tennis_return_stats", :force => true do |t|
    t.integer "returns_played"
    t.integer "matches_played"
    t.integer "first_service_return_points_won"
    t.integer "first_service_return_points_won_pct"
    t.integer "second_service_return_points_won"
    t.integer "second_service_return_points_won_pct"
    t.integer "return_games_played"
    t.integer "return_games_won"
    t.integer "return_games_won_pct"
    t.integer "break_points_played"
    t.integer "break_points_converted"
    t.integer "break_points_converted_pct"
    t.integer "net_points_won"
    t.integer "net_points_played"
    t.integer "points_won"
    t.integer "winners"
    t.integer "unforced_errors"
    t.integer "winners_forehand"
    t.integer "winners_backhand"
    t.integer "winners_volley"
  end

  create_table "tennis_service_stats", :force => true do |t|
    t.integer "services_played"
    t.integer "matches_played"
    t.integer "aces"
    t.integer "first_services_good"
    t.integer "first_services_good_pct"
    t.integer "first_service_points_won"
    t.integer "first_service_points_won_pct"
    t.integer "second_service_points_won"
    t.integer "second_service_points_won_pct"
    t.integer "service_games_played"
    t.integer "service_games_won"
    t.integer "service_games_won_pct"
    t.integer "break_points_played"
    t.integer "break_points_saved"
    t.integer "break_points_saved_pct"
    t.integer "service_points_won"
    t.integer "service_points_won_pct"
    t.integer "double_faults"
    t.string  "first_service_top_speed",       :limit => 100
    t.integer "second_services_good"
    t.integer "second_services_good_pct"
    t.string  "second_service_top_speed",      :limit => 100
    t.integer "net_points_won"
    t.integer "net_points_played"
    t.integer "points_won"
    t.integer "winners"
    t.integer "unforced_errors"
    t.integer "winners_forehand"
    t.integer "winners_backhand"
    t.integer "winners_volley"
  end

  create_table "tennis_set_stats", :force => true do |t|
    t.integer "net_points_won"
    t.integer "net_points_played"
    t.integer "points_won"
    t.integer "winners"
    t.integer "unforced_errors"
    t.integer "winners_forehand"
    t.integer "winners_backhand"
    t.integer "winners_volley"
  end

  create_table "tennis_team_stats", :force => true do |t|
    t.integer "net_points_won"
    t.integer "net_points_played"
    t.integer "points_won"
    t.integer "winners"
    t.integer "unforced_errors"
    t.integer "winners_forehand"
    t.integer "winners_backhand"
    t.integer "winners_volley"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

  create_table "wagering_moneylines", :force => true do |t|
    t.integer  "bookmaker_id",                :null => false
    t.integer  "event_id",                    :null => false
    t.datetime "date_time"
    t.integer  "team_id",                     :null => false
    t.integer  "person_id"
    t.string   "rotation_key", :limit => 100
    t.string   "comment"
    t.string   "vigorish",     :limit => 100
    t.string   "line",         :limit => 100
    t.string   "line_opening", :limit => 100
    t.string   "prediction",   :limit => 100
  end

  add_index "wagering_moneylines", ["bookmaker_id"], :name => "FK_wag_mon_boo_id__boo_id"
  add_index "wagering_moneylines", ["event_id"], :name => "FK_wag_mon_eve_id__eve_id"
  add_index "wagering_moneylines", ["team_id"], :name => "FK_wag_mon_tea_id__tea_id"

  create_table "wagering_odds_lines", :force => true do |t|
    t.integer  "bookmaker_id",                      :null => false
    t.integer  "event_id",                          :null => false
    t.datetime "date_time"
    t.integer  "team_id",                           :null => false
    t.integer  "person_id"
    t.string   "rotation_key",       :limit => 100
    t.string   "comment"
    t.string   "numerator",          :limit => 100
    t.string   "denominator",        :limit => 100
    t.string   "prediction",         :limit => 100
    t.string   "payout_calculation", :limit => 100
    t.string   "payout_amount",      :limit => 100
  end

  add_index "wagering_odds_lines", ["bookmaker_id"], :name => "FK_wag_odd_lin_boo_id__boo_id"
  add_index "wagering_odds_lines", ["event_id"], :name => "FK_wag_odd_lin_eve_id__eve_id"
  add_index "wagering_odds_lines", ["team_id"], :name => "FK_wag_odd_lin_tea_id__tea_id"

  create_table "wagering_runlines", :force => true do |t|
    t.integer  "bookmaker_id",                :null => false
    t.integer  "event_id",                    :null => false
    t.datetime "date_time"
    t.integer  "team_id",                     :null => false
    t.integer  "person_id"
    t.string   "rotation_key", :limit => 100
    t.string   "comment"
    t.string   "vigorish",     :limit => 100
    t.string   "line",         :limit => 100
    t.string   "line_opening", :limit => 100
    t.string   "line_value",   :limit => 100
    t.string   "prediction",   :limit => 100
  end

  add_index "wagering_runlines", ["bookmaker_id"], :name => "FK_wag_run_boo_id__boo_id"
  add_index "wagering_runlines", ["event_id"], :name => "FK_wag_run_eve_id__eve_id"
  add_index "wagering_runlines", ["team_id"], :name => "FK_wag_run_tea_id__tea_id"

  create_table "wagering_straight_spread_lines", :force => true do |t|
    t.integer  "bookmaker_id",                      :null => false
    t.integer  "event_id",                          :null => false
    t.datetime "date_time"
    t.integer  "team_id",                           :null => false
    t.integer  "person_id"
    t.string   "rotation_key",       :limit => 100
    t.string   "comment"
    t.string   "vigorish",           :limit => 100
    t.string   "line_value",         :limit => 100
    t.string   "line_value_opening", :limit => 100
    t.string   "prediction",         :limit => 100
  end

  add_index "wagering_straight_spread_lines", ["bookmaker_id"], :name => "FK_wag_str_spr_lin_boo_id__boo_id"
  add_index "wagering_straight_spread_lines", ["event_id"], :name => "FK_wag_str_spr_lin_eve_id__eve_id"
  add_index "wagering_straight_spread_lines", ["team_id"], :name => "FK_wag_str_spr_lin_tea_id__tea_id"

  create_table "wagering_total_score_lines", :force => true do |t|
    t.integer  "bookmaker_id",                 :null => false
    t.integer  "event_id",                     :null => false
    t.datetime "date_time"
    t.integer  "team_id",                      :null => false
    t.integer  "person_id"
    t.string   "rotation_key",  :limit => 100
    t.string   "comment"
    t.string   "vigorish",      :limit => 100
    t.string   "line_over",     :limit => 100
    t.string   "line_under",    :limit => 100
    t.string   "total",         :limit => 100
    t.string   "total_opening", :limit => 100
    t.string   "prediction",    :limit => 100
  end

  add_index "wagering_total_score_lines", ["bookmaker_id"], :name => "FK_wag_tot_sco_lin_boo_id__boo_id"
  add_index "wagering_total_score_lines", ["event_id"], :name => "FK_wag_tot_sco_lin_eve_id__eve_id"
  add_index "wagering_total_score_lines", ["team_id"], :name => "FK_wag_tot_sco_lin_tea_id__tea_id"

  create_table "weather_conditions", :force => true do |t|
    t.integer "event_id",                         :null => false
    t.string  "temperature",       :limit => 100
    t.string  "temperature_units", :limit => 40
    t.string  "humidity",          :limit => 100
    t.string  "clouds",            :limit => 100
    t.string  "wind_direction",    :limit => 100
    t.string  "wind_velocity",     :limit => 100
    t.string  "weather_code",      :limit => 100
  end

  add_index "weather_conditions", ["event_id"], :name => "IDX_FK_wea_con_eve_id__eve_id"

end

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

ActiveRecord::Schema.define(:version => 20110823061803) do

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
    t.integer "current_state"
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
  end

  create_table "american_football_passing_stats", :force => true do |t|
    t.string "passes_attempts",                 :limit => 100
    t.string "passes_completions",              :limit => 100
    t.string "passes_percentage",               :limit => 100
    t.string "passes_yards_gross",              :limit => 100
    t.string "passes_yards_net",                :limit => 100
    t.string "passes_yards_lost",               :limit => 100
    t.string "passes_touchdowns",               :limit => 100
    t.string "passes_touchdowns_percentage",    :limit => 100
    t.string "passes_interceptions",            :limit => 100
    t.string "passes_interceptions_percentage", :limit => 100
    t.string "passes_longest",                  :limit => 100
    t.string "passes_average_yards_per",        :limit => 100
    t.string "passer_rating",                   :limit => 100
    t.string "receptions_total",                :limit => 100
    t.string "receptions_yards",                :limit => 100
    t.string "receptions_touchdowns",           :limit => 100
    t.string "receptions_first_down",           :limit => 100
    t.string "receptions_longest",              :limit => 100
    t.string "receptions_average_yards_per",    :limit => 100
  end

  create_table "american_football_penalties_stats", :force => true do |t|
    t.string "penalties_total",     :limit => 100
    t.string "penalty_yards",       :limit => 100
    t.string "penalty_first_downs", :limit => 100
  end

  create_table "american_football_rushing_stats", :force => true do |t|
    t.string "rushes_attempts",           :limit => 100
    t.string "rushes_yards",              :limit => 100
    t.string "rushes_touchdowns",         :limit => 100
    t.string "rushing_average_yards_per", :limit => 100
    t.string "rushes_first_down",         :limit => 100
    t.string "rushes_longest",            :limit => 100
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

  create_table "backup_picks", :id => false, :force => true do |t|
    t.integer "user_id",    :null => false
    t.integer "person_id",  :null => false
    t.integer "preference"
  end

  add_index "backup_picks", ["person_id"], :name => "index_backup_picks_person"
  add_index "backup_picks", ["user_id"], :name => "index_backup_picks_user"

  create_table "baseball_defensive_group", :force => true do |t|
  end

  create_table "bookmakers", :force => true do |t|
    t.string  "bookmaker_key", :limit => 100
    t.integer "publisher_id",                 :null => false
    t.integer "location_id"
  end

  add_index "bookmakers", ["location_id"], :name => "FK_boo_loc_id__loc_id"
  add_index "bookmakers", ["publisher_id"], :name => "FK_boo_pub_id__pub_id"

  create_table "conferences", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  create_table "db_info", :id => false, :force => true do |t|
    t.string "version", :limit => 100, :default => "16", :null => false
  end

  add_index "db_info", ["version"], :name => "IDX_db_info_1"

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
  add_index "display_names", ["entity_type"], :name => "IDX_display_names_2"

  create_table "divisions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "document_fixture_events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "document_package_entries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "draftable_players", :id => false, :force => true do |t|
    t.integer "id",                                              :null => false
    t.string  "full_name",       :limit => 50,                   :null => false
    t.string  "position",        :limit => 10
    t.date    "dob"
    t.string  "college",         :limit => 50
    t.integer "contract_start"
    t.integer "contract_length"
    t.integer "contract_amount",               :default => 0
    t.string  "free_agent",                    :default => "NO", :null => false
    t.integer "person_id",                     :default => 0,    :null => false
  end

  create_table "drafts", :force => true do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "started",          :default => false
    t.boolean  "finished",         :default => false
    t.integer  "league_id",                           :null => false
    t.integer  "number_of_rounds", :default => 30,    :null => false
  end

  add_index "drafts", ["league_id"], :name => "index_drafts_league"

  create_table "dynasty_dollars", :force => true do |t|
    t.integer "team_id", :null => false
  end

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

  add_index "events_sub_seasons", ["event_id"], :name => "FK_eve_sub_sea_eve_id__eve_id"
  add_index "events_sub_seasons", ["sub_season_id"], :name => "FK_eve_sub_sea_sub_sea_id__sub_sea_id"

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

  create_table "leagues", :force => true do |t|
    t.string  "name", :limit => 50,                 :null => false
    t.integer "size",               :default => 15, :null => false
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

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "person_id",                                                 :null => false
    t.string   "membership_type",        :limit => 40,  :default => "Team", :null => false
    t.integer  "membership_id",                                             :null => false
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

  create_table "person_scores", :force => true do |t|
    t.integer  "score",      :null => false
    t.integer  "person_id",  :null => false
    t.datetime "created_at", :null => false
  end

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

  create_table "picking_orders", :id => false, :force => true do |t|
    t.integer "round_id",            :null => false
    t.integer "position",            :null => false
    t.integer "user_team_league_id", :null => false
    t.integer "user_team_user_id",   :null => false
  end

  add_index "picking_orders", ["round_id"], :name => "index_picking_orders_round"
  add_index "picking_orders", ["user_team_league_id", "user_team_user_id"], :name => "index_picking_orders_user_team"

  create_table "picks", :id => false, :force => true do |t|
    t.integer "round_id",            :null => false
    t.integer "person_id",           :null => false
    t.integer "user_team_league_id", :null => false
    t.integer "user_team_user_id",   :null => false
  end

  add_index "picks", ["person_id"], :name => "index_picks_person"
  add_index "picks", ["round_id"], :name => "index_picks_round"
  add_index "picks", ["user_team_league_id", "user_team_user_id"], :name => "index_picks_user_team"

  create_table "positions", :force => true do |t|
    t.integer "affiliation_id",                :null => false
    t.string  "abbreviation",   :limit => 100, :null => false
    t.string  "teamtype",       :limit => 15,  :null => false
    t.string  "name",           :limit => 25,  :null => false
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
    t.string "role_key",  :limit => 100, :null => false
    t.string "role_name", :limit => 100
    t.string "comment",   :limit => 100
  end

  add_index "roles", ["role_key"], :name => "IDX_roles_1"

  create_table "rounds", :force => true do |t|
    t.integer  "draft_id",                       :null => false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "started",     :default => false, :null => false
    t.boolean  "finished",    :default => false, :null => false
  end

  add_index "rounds", ["draft_id"], :name => "index_rounds_draft"

  create_table "salaries", :id => false, :force => true do |t|
    t.integer "id",                                              :null => false
    t.string  "full_name",       :limit => 50,                   :null => false
    t.string  "position",        :limit => 10
    t.date    "dob"
    t.string  "college",         :limit => 50
    t.integer "contract_start"
    t.integer "contract_length"
    t.integer "contract_amount",               :default => 0
    t.string  "free_agent",                    :default => "NO", :null => false
    t.integer "person_id",                     :default => 0,    :null => false
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

  create_table "sports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports_properties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string  "stat_repository_type", :limit => 100
    t.integer "stat_repository_id",                  :null => false
    t.string  "stat_holder_type",     :limit => 100
    t.integer "stat_holder_id"
    t.string  "stat_coverage_type",   :limit => 100
    t.integer "stat_coverage_id"
    t.string  "stat_membership_type", :limit => 40
    t.integer "stat_membership_id"
    t.string  "context",              :limit => 40,  :null => false
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
  add_index "team_phases", ["affiliation_id"], :name => "index_team_phases_affiliation"
  add_index "team_phases", ["end_season_id"], :name => "FK_tea_aff_pha_end_sea_id__sea_id"
  add_index "team_phases", ["role_id"], :name => "FK_tea_aff_pha_rol_id__rol_id"
  add_index "team_phases", ["start_season_id"], :name => "FK_tea_aff_pha_sta_sea_id__sea_id"
  add_index "team_phases", ["team_id"], :name => "FK_tea_aff_pha_tea_id__tea_id"
  add_index "team_phases", ["team_id"], :name => "index_team_phases_team"

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

  create_table "trades", :force => true do |t|
    t.integer "league_id",       :null => false
    t.integer "initial_team_id", :null => false
    t.integer "second_team_id",  :null => false
  end

  create_table "user_team_persons", :force => true do |t|
    t.integer "user_team_id"
    t.integer "person_id"
  end

  create_table "user_teams", :id => false, :force => true do |t|
    t.integer "league_id",               :null => false
    t.string  "name",      :limit => 50, :null => false
    t.integer "user_id",                 :null => false
  end

  add_index "user_teams", ["league_id"], :name => "index_user_teams_league"
  add_index "user_teams", ["user_id"], :name => "index_user_teams_user"

  create_table "users", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",     :limit => 128,                :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "note"
    t.integer  "experience"
    t.datetime "reset_password_sent_at"
    t.datetime "last_seen"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

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

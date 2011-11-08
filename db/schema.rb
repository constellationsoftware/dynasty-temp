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


ActiveRecord::Schema.define(:version => 20111107172703) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "admin_users", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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

  create_table "leagues", :force => true do |t|
    t.string   "name",       :limit => 50,                 :null => false
    t.integer  "size",                     :default => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
  end

  add_index "leagues", ["manager_id"], :name => "index_leagues_on_manager_id"

  create_table "person_scores", :force => true do |t|
    t.integer  "score",      :null => false
    t.integer  "person_id",  :null => false
    t.datetime "created_at", :null => false
  end

  create_table "picks", :force => true do |t|
    t.integer  "person_id"
    t.integer  "draft_id",   :null => false
    t.integer  "team_id",    :null => false
    t.integer  "pick_order", :null => false
    t.datetime "picked_at"
  end

  create_table "players", :force => true do |t|
    t.integer "user_team_id"
    t.integer "person_id"
  end

  create_table "salaries", :force => true do |t|
    t.string  "full_name",       :limit => 50, :null => false
    t.string  "position",        :limit => 10
    t.integer "contract_amount"
    t.integer "points"
    t.integer "rating"
    t.float   "consistency"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "trades", :force => true do |t|
    t.integer "league_id",       :null => false
    t.integer "initial_team_id", :null => false
    t.integer "second_team_id",  :null => false
  end

  create_table "user_teams", :force => true do |t|
    t.integer "league_id",               :null => false
    t.string  "name",      :limit => 50, :null => false
    t.integer "user_id",                 :null => false
  end

  add_index "user_teams", ["league_id"], :name => "index_user_teams_league"
  add_index "user_teams", ["user_id"], :name => "index_user_teams_user"

  create_table "users", :force => true do |t|
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
    t.integer  "league_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

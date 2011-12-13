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

ActiveRecord::Schema.define(:version => 20111212212010) do

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

  create_table "drafts", :force => true do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "league_id",                                     :null => false
    t.integer  "number_of_rounds",              :default => 30, :null => false
    t.integer  "current_pick_id",  :limit => 2
    t.string   "status"
  end

  add_index "drafts", ["league_id"], :name => "index_drafts_league"
  add_index "drafts", ["status"], :name => "index_drafts_on_status"

  create_table "dynasty_dollars", :force => true do |t|
    t.integer "team_id", :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name",       :limit => 50,                 :null => false
    t.integer  "size",                     :default => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
    t.string   "slug"
  end

  add_index "leagues", ["manager_id"], :name => "index_leagues_on_manager_id"
  add_index "leagues", ["slug"], :name => "index_leagues_on_slug", :unique => true

  create_table "person_scores", :force => true do |t|
    t.integer  "score",      :null => false
    t.integer  "person_id",  :null => false
    t.datetime "created_at", :null => false
  end

  create_table "picks", :force => true do |t|
    t.integer  "person_id"
    t.integer  "draft_id",   :default => 0, :null => false
    t.integer  "team_id",                   :null => false
    t.integer  "pick_order", :default => 0, :null => false
    t.datetime "picked_at"
    t.integer  "round",                     :null => false
  end

  create_table "players", :force => true do |t|
    t.integer "user_team_id"
    t.integer "person_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "user_team_balances", :force => true do |t|
    t.integer  "balance_cents", :limit => 8, :default => 0, :null => false
    t.integer  "user_team_id",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_teams", :force => true do |t|
    t.integer "league_id",                                        :null => false
    t.string  "name",           :limit => 50,                     :null => false
    t.integer "user_id",                                          :null => false
    t.boolean "is_online",                     :default => false, :null => false
    t.binary  "uuid",           :limit => 255
    t.string  "last_socket_id"
  end

  add_index "user_teams", ["league_id"], :name => "index_user_teams_league"
  add_index "user_teams", ["user_id"], :name => "index_user_teams_user"
  add_index "user_teams", ["uuid"], :name => "index_user_teams_on_uuid", :length => {"uuid"=>16}

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
    t.string   "name"
    t.string   "role"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

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

end

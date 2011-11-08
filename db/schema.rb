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

ActiveRecord::Schema.define(:version => 20111108013532) do

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

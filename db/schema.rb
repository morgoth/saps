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

ActiveRecord::Schema.define(:version => 20111002170441) do

  create_table "achievements", :force => true do |t|
    t.date      "played_at"
    t.string    "photo_url"
    t.text      "description"
    t.integer   "place"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string    "name"
    t.text      "content"
    t.integer   "post_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "three_zero"
    t.integer  "three_two"
    t.integer  "zero_three"
    t.integer  "two_three"
  end

  create_table "matches", :force => true do |t|
    t.integer   "home_team_id"
    t.integer   "visitor_team_id"
    t.timestamp "hour"
    t.string    "score"
    t.integer   "round_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "players", :force => true do |t|
    t.date     "birth_date"
    t.integer  "height"
    t.string   "position"
    t.text     "about"
    t.boolean  "active",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_url"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "posts", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.string    "name"
    t.date      "date"
    t.integer   "league_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "team_tables", :force => true do |t|
    t.integer "league_id"
    t.integer "team_id"
    t.integer "points",         :default => 0
    t.integer "sets_won",       :default => 0
    t.integer "sets_lost",      :default => 0
    t.integer "matches_played", :default => 0
  end

  create_table "teams", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "login"
    t.string    "crypted_password",          :limit => 40
    t.string    "salt",                      :limit => 40
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "remember_token"
    t.timestamp "remember_token_expires_at"
    t.string    "persistence_token"
    t.integer   "login_count"
    t.timestamp "last_request_at"
    t.string    "perishable_token",                        :default => "", :null => false
    t.string    "email"
  end

end

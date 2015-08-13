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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150518200117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestant_tribes", force: true do |t|
    t.integer  "contestant_id"
    t.integer  "tribe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contestant_tribes", ["contestant_id"], name: "index_contestant_tribes_on_contestant_id", using: :btree
  add_index "contestant_tribes", ["tribe_id"], name: "index_contestant_tribes_on_tribe_id", using: :btree

  create_table "contestants", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "seasons_id"
    t.string   "from"
    t.string   "job"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hometown"
    t.string   "image_url"
  end

  add_index "contestants", ["seasons_id"], name: "index_contestants_on_seasons_id", using: :btree

  create_table "contestants_seasons", id: false, force: true do |t|
    t.integer  "contestant_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestants_users", force: true do |t|
    t.integer  "contestant_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drafts", force: true do |t|
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "scheduled"
  end

  add_index "drafts", ["season_id"], name: "index_drafts_on_season_id", using: :btree

  create_table "drafts_contestants", force: true do |t|
    t.integer  "draft_id"
    t.integer  "contestant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "season_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "air_date"
  end

  create_table "picks", force: true do |t|
    t.integer  "draft_id"
    t.integer  "contestant_id"
    t.integer  "user_id"
    t.string   "pick_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_id"
    t.string   "image_url"
  end

  create_table "second_chance_potentials", force: true do |t|
    t.string   "name"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  create_table "second_chance_votes", force: true do |t|
    t.integer  "second_chance_potential_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tribes", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  add_index "tribes", ["season_id"], name: "index_tribes_on_season_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   default: "user"
    t.boolean  "show_spoilers",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vote_outs", force: true do |t|
    t.integer  "season_id"
    t.integer  "contestant_id"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

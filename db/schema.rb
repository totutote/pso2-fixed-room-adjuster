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

ActiveRecord::Schema.define(version: 20160730073808) do

  create_table "groups", force: :cascade do |t|
    t.string   "uuid",           limit: 73
    t.string   "name"
    t.text     "description"
    t.boolean  "is_hidden_page"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "player_characters", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "name"
    t.string   "main_class"
    t.string   "sub_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "player_id_name"
    t.string   "nick_name"
    t.boolean  "is_guest_user",  default: true, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "room_members", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "player_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "acceptable_room_leader"
    t.boolean  "acceptable_party_leader"
    t.integer  "room_number"
    t.integer  "party_number"
    t.boolean  "is_room_leader"
    t.boolean  "is_party_leader"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.string   "room_pass"
    t.integer  "min_player"
    t.integer  "max_player"
    t.integer  "block_no"
    t.string   "block_place"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "recruitment_deadline"
    t.datetime "meeting_time"
    t.datetime "quest_start_time"
    t.datetime "quest_end_time"
    t.text     "description"
    t.string   "short_url"
    t.boolean  "is_hidden_page"
    t.string   "uuid",                 limit: 73
    t.integer  "ship_number"
    t.integer  "group_id"
  end

  create_table "test_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

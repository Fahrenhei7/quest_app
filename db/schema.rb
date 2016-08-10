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

ActiveRecord::Schema.define(version: 20160810150845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "missions", force: :cascade do |t|
    t.text     "task"
    t.string   "keys",       default: [],              array: true
    t.integer  "quest_id"
    t.integer  "difficulty"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["quest_id"], name: "index_missions_on_quest_id", using: :btree
  end

  create_table "missions_users", id: false, force: :cascade do |t|
    t.integer "mission_id", null: false
    t.integer "user_id",    null: false
    t.index ["mission_id"], name: "index_missions_users_on_mission_id", using: :btree
    t.index ["user_id"], name: "index_missions_users_on_user_id", using: :btree
  end

  create_table "quest_user_joins", force: :cascade do |t|
    t.integer  "quest_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_user_joins_on_quest_id", using: :btree
    t.index ["user_id"], name: "index_quest_user_joins_on_user_id", using: :btree
  end

  create_table "quests", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["creator_id"], name: "index_quests_on_creator_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "created_quests_id"
    t.integer  "points",                 default: 0
    t.index ["created_quests_id"], name: "index_users_on_created_quests_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end

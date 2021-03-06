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

ActiveRecord::Schema.define(version: 20160813011152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", force: :cascade do |t|
    t.string   "title",          null: false
    t.text     "description"
    t.text     "notes"
    t.integer  "game_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["game_master_id"], name: "index_adventures_on_game_master_id", using: :btree
  end

  create_table "aspects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "aspectable_type"
    t.integer  "aspectable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["aspectable_type", "aspectable_id"], name: "index_aspects_on_aspectable_type_and_aspectable_id", using: :btree
  end

  create_table "character_skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "npc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consequences", force: :cascade do |t|
    t.string   "name"
    t.string   "severity"
    t.integer  "shift_value"
    t.integer  "npc_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "npcs", force: :cascade do |t|
    t.string   "name"
    t.string   "npc_type"
    t.text     "background"
    t.integer  "system_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "mental_stress",       default: 0
    t.integer  "physical_stress",     default: 0
    t.integer  "max_mental_stress",   default: 2
    t.integer  "max_physical_stress", default: 2
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "level",       default: 0, null: false
    t.text     "description"
    t.integer  "system_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "overcome"
    t.text     "advantage"
    t.text     "attack"
    t.text     "defend"
    t.boolean  "default_set"
    t.text     "special"
    t.index ["system_id"], name: "index_skills_on_system_id", using: :btree
  end

  create_table "stunts", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.integer  "npc_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      default: false
    t.string   "setting",     default: "no setting chosen"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.date     "birthday"
  end

  add_foreign_key "adventures", "users", column: "game_master_id"
end

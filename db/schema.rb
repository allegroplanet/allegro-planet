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

ActiveRecord::Schema.define(version: 20170226065723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_releases", force: :cascade do |t|
    t.string   "version_num"
    t.text     "notes"
    t.integer  "game_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_game_releases_on_game_id", using: :btree
  end

  create_table "game_screenshots", force: :cascade do |t|
    t.string   "image"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_screenshots_on_game_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.index ["game_id"], name: "index_games_users_on_game_id", using: :btree
    t.index ["user_id"], name: "index_games_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "slug"
  end

  add_foreign_key "game_releases", "games"
  add_foreign_key "game_screenshots", "games"
end

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

ActiveRecord::Schema.define(version: 2019_10_20_182233) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "handle", null: false
    t.string "title", null: false
    t.text "body_markdown", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: true, null: false
    t.index ["handle"], name: "index_articles_on_handle"
  end

  create_table "game_files", id: :serial, force: :cascade do |t|
    t.string "file"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_release_id"
    t.index ["game_release_id"], name: "index_game_files_on_game_release_id"
  end

  create_table "game_releases", id: :serial, force: :cascade do |t|
    t.string "version_num"
    t.text "notes"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_releases_on_game_id"
  end

  create_table "game_screenshots", id: :serial, force: :cascade do |t|
    t.string "image"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_screenshots_on_game_id"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "handle"
    t.index ["handle"], name: "index_games_on_handle"
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.index ["game_id"], name: "index_games_users_on_game_id"
    t.index ["user_id"], name: "index_games_users_on_user_id"
  end

  create_table "github_webhook_events", force: :cascade do |t|
    t.string "event"
    t.text "payload_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "github_webhook_id"
    t.index ["github_webhook_id"], name: "index_github_webhook_events_on_github_webhook_id"
  end

  create_table "github_webhooks", force: :cascade do |t|
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.index ["game_id"], name: "index_github_webhooks_on_game_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "website"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "handle"
    t.index ["handle"], name: "index_users_on_handle"
  end

  add_foreign_key "game_releases", "games"
  add_foreign_key "game_screenshots", "games"
  add_foreign_key "github_webhook_events", "github_webhooks"
  add_foreign_key "github_webhooks", "games"
end

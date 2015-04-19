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

ActiveRecord::Schema.define(version: 20150418233837) do

  create_table "game_concepts", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "concept"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_concepts", ["concept"], name: "index_game_concepts_on_concept"
  add_index "game_concepts", ["game_id", "concept"], name: "index_game_concepts_on_game_id_and_concept", unique: true
  add_index "game_concepts", ["game_id"], name: "index_game_concepts_on_game_id"

  create_table "game_genres", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_genres", ["game_id", "genre"], name: "index_game_genres_on_game_id_and_genre", unique: true
  add_index "game_genres", ["game_id"], name: "index_game_genres_on_game_id"
  add_index "game_genres", ["genre"], name: "index_game_genres_on_genre"

  create_table "game_themes", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "theme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_themes", ["game_id", "theme"], name: "index_game_themes_on_game_id_and_theme", unique: true
  add_index "game_themes", ["game_id"], name: "index_game_themes_on_game_id"
  add_index "game_themes", ["theme"], name: "index_game_themes_on_theme"

  create_table "games", force: :cascade do |t|
    t.integer  "appid"
    t.integer  "gb_id"
    t.string   "name"
    t.string   "api_detail_url"
    t.datetime "date_last_updated"
    t.string   "dec"
    t.string   "image"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "games", ["appid"], name: "index_games_on_appid", unique: true
  add_index "games", ["gb_id"], name: "index_games_on_gb_id", unique: true
  add_index "games", ["id"], name: "index_games_on_id", unique: true

  create_table "users", force: :cascade do |t|
    t.integer  "steamid"
    t.integer  "steam_level"
    t.string   "profile_pic"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "users", ["id"], name: "index_users_on_id", unique: true
  add_index "users", ["steamid"], name: "index_users_on_steamid", unique: true

  create_table "users_games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "time_played"
  end

  add_index "users_games", ["game_id"], name: "index_users_games_on_game_id"
  add_index "users_games", ["user_id", "game_id"], name: "index_users_games_on_user_id_and_game_id", unique: true
  add_index "users_games", ["user_id"], name: "index_users_games_on_user_id"

end

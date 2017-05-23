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

ActiveRecord::Schema.define(version: 20170523134433) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "gn_id"
    t.string   "artist"
    t.string   "title"
    t.date     "release_date"
    t.integer  "track_count"
    t.string   "genre"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "moods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "gn_id"
    t.integer  "album_id"
    t.string   "artist"
    t.string   "title"
    t.integer  "track_num"
    t.string   "mood"
    t.string   "tempo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs_moods", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "song_id"
    t.integer "mood_id"
    t.index ["mood_id"], name: "index_songs_moods_on_mood_id", using: :btree
    t.index ["song_id"], name: "index_songs_moods_on_song_id", using: :btree
  end

  create_table "songs_tempos", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "song_id"
    t.integer "tempo_id"
    t.index ["song_id"], name: "index_songs_tempos_on_song_id", using: :btree
    t.index ["tempo_id"], name: "index_songs_tempos_on_tempo_id", using: :btree
  end

  create_table "tempos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "songs_moods", "moods"
  add_foreign_key "songs_moods", "songs"
  add_foreign_key "songs_tempos", "songs"
  add_foreign_key "songs_tempos", "tempos"
end

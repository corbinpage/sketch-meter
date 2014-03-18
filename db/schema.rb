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

ActiveRecord::Schema.define(version: 20140317152841) do

  create_table "scans", force: true do |t|
    t.string   "username"
    t.integer  "score"
    t.string   "error"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "average_sentiment"
  end

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.string   "twitter_id"
    t.datetime "tweet_time"
    t.integer  "score"
    t.text     "dirty_words"
    t.integer  "scan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "sentiment_score"
    t.string   "sentiment_summary"
  end

  add_index "tweets", ["scan_id"], name: "index_tweets_on_scan_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

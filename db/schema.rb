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

ActiveRecord::Schema.define(version: 20141127033545) do

  create_table "bars", force: true do |t|
    t.integer  "neighborhood_id"
    t.string   "name"
    t.string   "url"
    t.string   "stars_img"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boroughs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "median_buy_price"
    t.string   "median_rental_price"
    t.integer  "median_rental_price_integer"
    t.string   "noko_search_url"
    t.string   "noko_img_url_1"
    t.string   "noko_img_url_2"
    t.string   "noko_img_url_3"
    t.string   "noko_listing_url_1"
    t.string   "noko_listing_url_2"
    t.string   "noko_listing_url_3"
    t.string   "noko_monthly_rent_1"
    t.string   "noko_monthly_rent_2"
    t.string   "noko_monthly_rent_3"
    t.string   "photo_url"
    t.string   "median_buy_price_string"
    t.integer  "borough_id"
  end

  create_table "restaurants", force: true do |t|
    t.integer  "neighborhood_id"
    t.string   "name"
    t.string   "url"
    t.string   "stars_img"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "commute_address"
    t.string   "commute_city"
    t.boolean  "want_to_rent",     default: true
    t.boolean  "want_to_buy",      default: true
    t.integer  "min_rent_price",   default: 0
    t.integer  "max_rent_price",   default: 10000000
    t.integer  "min_buy_price",    default: 0
    t.integer  "max_buy_price",    default: 10000000
    t.boolean  "likes_manhattan",  default: true
    t.boolean  "likes_brooklyn",   default: true
    t.boolean  "likes_queens",     default: true
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

end

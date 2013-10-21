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

ActiveRecord::Schema.define(version: 20131012073017) do

  create_table "bikes", force: true do |t|
    t.string   "serial"
    t.string   "frame_make"
    t.string   "frame_model"
    t.string   "color"
    t.text     "description"
    t.string   "status",      default: "normal", null: false
    t.string   "hash_id",                        null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "phone"
    t.integer  "bike_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["bike_id"], name: "index_contacts_on_bike_id"

  create_table "incidents", force: true do |t|
    t.datetime "last_seen",                              null: false
    t.string   "last_location",                          null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "police_incident_number"
    t.string   "officer_name"
    t.string   "station"
    t.boolean  "resolved",               default: false, null: false
    t.integer  "bike_id",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents", ["bike_id"], name: "index_incidents_on_bike_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                       null: false
    t.string   "phone"
    t.string   "password"
    t.string   "user_type"
    t.string   "role",       default: "user", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

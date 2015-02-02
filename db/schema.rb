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

ActiveRecord::Schema.define(version: 20150201231619) do

  create_table "analyzed_fields", force: :cascade do |t|
    t.integer  "classification_id"
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "analyzed_fields", ["classification_id"], name: "index_analyzed_fields_on_classification_id"

  create_table "classifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "classified_field_id"
    t.float    "probability"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "classified_fields", force: :cascade do |t|
    t.string   "name"
    t.integer  "classified_model_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "classified_models", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "gender"
    t.integer  "height"
    t.integer  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.integer  "analyzed_field_id"
    t.string   "name"
    t.float    "value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "statistics", ["analyzed_field_id"], name: "index_statistics_on_analyzed_field_id"

end

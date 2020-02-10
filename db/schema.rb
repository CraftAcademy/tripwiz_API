# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_07_170314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "rating"
    t.string "lat"
    t.string "lng"
    t.bigint "activity_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_type_id"], name: "index_activities_on_activity_type_id"
  end

  create_table "activity_types", force: :cascade do |t|
    t.string "activity_type"
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "max_price"
    t.index ["trip_id"], name: "index_activity_types_on_trip_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lng"
    t.string "price"
    t.string "address"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "destination"
    t.string "lat"
    t.string "lng"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "days"
  end

  add_foreign_key "activities", "activity_types"
  add_foreign_key "activity_types", "trips"
end

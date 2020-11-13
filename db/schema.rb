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

ActiveRecord::Schema.define(version: 2020_11_13_164510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_group_cases", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.datetime "query_date"
    t.string "age_group"
    t.integer "total_cases"
    t.integer "total_case_rate"
    t.integer "total_deaths"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_age_group_cases_on_state_id"
  end

  create_table "counties", force: :cascade do |t|
    t.datetime "query_date"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ct_users", force: :cascade do |t|
    t.string "username"
    t.datetime "query_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.datetime "query_date"
    t.string "name"
    t.integer "total_tests"
    t.integer "total_cases"
    t.integer "confirmed_cases"
    t.integer "hospitalized_cases"
    t.integer "confirmed_deaths"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "towns", force: :cascade do |t|
    t.datetime "query_date"
    t.string "name"
    t.bigint "county_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_towns_on_county_id"
  end

  create_table "user_states", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "ct_user_id", null: false
    t.datetime "query_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ct_user_id"], name: "index_user_states_on_ct_user_id"
    t.index ["state_id"], name: "index_user_states_on_state_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "age_group_cases", "states"
  add_foreign_key "towns", "counties"
  add_foreign_key "user_states", "ct_users"
  add_foreign_key "user_states", "states"
end

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

ActiveRecord::Schema.define(version: 2020_10_31_190130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_group_cases", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "age_group_data_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["age_group_data_id"], name: "index_age_group_cases_on_age_group_data_id"
    t.index ["state_id"], name: "index_age_group_cases_on_state_id"
  end

  create_table "age_group_data", force: :cascade do |t|
    t.integer "query_date"
    t.integer "cases_0_9"
    t.integer "cases_10_19"
    t.integer "cases_20_29"
    t.integer "cases_30_39"
    t.integer "cases_40_49"
    t.integer "cases_50_59"
    t.integer "cases_60_69"
    t.integer "cases_70_79"
    t.integer "cases_80_and_older"
    t.integer "deaths_0_9"
    t.integer "deaths_10_19"
    t.integer "eaths_20_29"
    t.integer "deaths_30_39"
    t.integer "deaths_40_49"
    t.integer "deaths_50_59"
    t.integer "deaths_60_69"
    t.integer "deaths_70_79"
    t.integer "deaths_80_and_older"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cases", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "county_id", null: false
    t.bigint "town_id", null: false
    t.date "query_date"
    t.integer "num_cases"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_cases_on_county_id"
    t.index ["state_id"], name: "index_cases_on_state_id"
    t.index ["town_id"], name: "index_cases_on_town_id"
  end

  create_table "counties", force: :cascade do |t|
    t.date "query_date"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "covid_stats", force: :cascade do |t|
    t.bigint "data_point_id", null: false
    t.bigint "state_id", null: false
    t.bigint "county_id", null: false
    t.bigint "town_id", null: false
    t.date "query_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_covid_stats_on_county_id"
    t.index ["data_point_id"], name: "index_covid_stats_on_data_point_id"
    t.index ["state_id"], name: "index_covid_stats_on_state_id"
    t.index ["town_id"], name: "index_covid_stats_on_town_id"
  end

  create_table "data_points", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "query_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "covid_stat_id", null: false
    t.index ["covid_stat_id"], name: "index_data_points_on_covid_stat_id"
    t.index ["user_id"], name: "index_data_points_on_user_id"
  end

  create_table "deaths", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "county_id", null: false
    t.bigint "town_id", null: false
    t.date "query_date"
    t.integer "num_deaths"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_deaths_on_county_id"
    t.index ["state_id"], name: "index_deaths_on_state_id"
    t.index ["town_id"], name: "index_deaths_on_town_id"
  end

  create_table "ethnic_cases", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "ethnic_data_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ethnic_data_id"], name: "index_ethnic_cases_on_ethnic_data_id"
    t.index ["state_id"], name: "index_ethnic_cases_on_state_id"
  end

  create_table "ethnic_data", force: :cascade do |t|
    t.date "query_date"
    t.integer "cases_hispanic"
    t.integer "cases_NH_American_Indian_or_Alaskan_Native"
    t.integer "cases_NH_Asian_or_Pacific_Islander"
    t.integer "cases_NH_Black"
    t.integer "cases_NH_Multracial"
    t.integer "cases_NH_White"
    t.integer "cases_NH_Other"
    t.integer "cases_Unknown"
    t.integer "deaths_hispanic"
    t.integer "deaths_NH_American_Indian_or_Alaskan_Native"
    t.integer "deaths_NH_Asian_or_Pacific_Islander"
    t.integer "deaths_NH_Black"
    t.integer "deaths_NH_Multracial"
    t.integer "deaths_NH_White"
    t.integer "deaths_NH_Other"
    t.integer "deaths_Unknown"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gender_cases", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "gender_data_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gender_data_id"], name: "index_gender_cases_on_gender_data_id"
    t.index ["state_id"], name: "index_gender_cases_on_state_id"
  end

  create_table "gender_data", force: :cascade do |t|
    t.date "query_date"
    t.integer "male_cases"
    t.integer "female_cases"
    t.integer "male_deaths"
    t.integer "female_deaths"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hospitalizations", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "county_id", null: false
    t.date "query_date"
    t.integer "num_hospitalizations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_hospitalizations_on_county_id"
    t.index ["state_id"], name: "index_hospitalizations_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.date "query_date"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_tests"
    t.integer "total_cases"
    t.integer "confirmed_cases"
    t.integer "hospitalized_cases"
    t.integer "confirmed_deaths"
    t.integer "cases_age_0_9"
    t.integer "cases_age_10_19"
    t.integer "cases_age_20_29"
    t.integer "cases_age_30_39"
    t.integer "cases_age_40_49"
    t.integer "cases_age_50_59"
    t.integer "cases_age_60_69"
    t.integer "cases_age_70_79"
    t.integer "cases_age_80_older"
  end

  create_table "tests", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "county_id", null: false
    t.bigint "town_id", null: false
    t.date "query_date"
    t.integer "num_tests"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_tests_on_county_id"
    t.index ["state_id"], name: "index_tests_on_state_id"
    t.index ["town_id"], name: "index_tests_on_town_id"
  end

  create_table "towns", force: :cascade do |t|
    t.date "query_date"
    t.string "name"
    t.bigint "county_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["county_id"], name: "index_towns_on_county_id"
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

  add_foreign_key "age_group_cases", "age_group_data", column: "age_group_data_id"
  add_foreign_key "age_group_cases", "states"
  add_foreign_key "cases", "counties"
  add_foreign_key "cases", "states"
  add_foreign_key "cases", "towns"
  add_foreign_key "covid_stats", "counties"
  add_foreign_key "covid_stats", "data_points"
  add_foreign_key "covid_stats", "states"
  add_foreign_key "covid_stats", "towns"
  add_foreign_key "data_points", "covid_stats"
  add_foreign_key "data_points", "users"
  add_foreign_key "deaths", "counties"
  add_foreign_key "deaths", "states"
  add_foreign_key "deaths", "towns"
  add_foreign_key "ethnic_cases", "ethnic_data", column: "ethnic_data_id"
  add_foreign_key "ethnic_cases", "states"
  add_foreign_key "gender_cases", "gender_data", column: "gender_data_id"
  add_foreign_key "gender_cases", "states"
  add_foreign_key "hospitalizations", "counties"
  add_foreign_key "hospitalizations", "states"
  add_foreign_key "tests", "counties"
  add_foreign_key "tests", "states"
  add_foreign_key "tests", "towns"
  add_foreign_key "towns", "counties"
end

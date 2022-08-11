# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_09_072625) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "day_record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "day_record_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "day_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "year_month_date", null: false
    t.integer "food_cost", default: 0
    t.integer "commodity", default: 0
    t.integer "clothing", default: 0
    t.integer "educate", default: 0
    t.integer "medical_beauty", default: 0
    t.integer "transport", default: 0
    t.integer "socializing", default: 0
    t.integer "amusement", default: 0
    t.integer "day_other", default: 0
    t.text "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "month_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "year_month", null: false
    t.integer "brought_forward", default: 0
    t.integer "income", default: 0
    t.integer "water_fare", default: 0
    t.integer "gas_fare", default: 0
    t.integer "electrical_fare", default: 0
    t.integer "telephone_fare", default: 0
    t.integer "deposit", default: 0
    t.integer "insurance", default: 0
    t.integer "credit_card", default: 0
    t.integer "month_other", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

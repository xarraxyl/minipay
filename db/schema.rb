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

ActiveRecord::Schema[8.1].define(version: 2026_07_13_131715) do
  create_table "merchants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "email"
    t.string "name"
    t.integer "status", default: 1
    t.integer "total_transaction_sum"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.string "customer_email"
    t.string "customer_phone"
    t.integer "merchant_id", null: false
    t.integer "status"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.integer "merchant_id"
    t.string "password_digest", null: false
    t.integer "role", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["merchant_id"], name: "index_users_on_merchant_id"
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "transactions", "merchants"
  add_foreign_key "users", "merchants"
end

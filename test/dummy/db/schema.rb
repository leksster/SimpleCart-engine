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

ActiveRecord::Schema.define(version: 20160312151409) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "phone"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "type"
  end

  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id"

  create_table "bicycles", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.string   "expiration_year"
    t.string   "expiration_month"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "order_id"
  end

  add_index "credit_cards", ["order_id"], name: "index_credit_cards_on_order_id"

  create_table "deliveries", force: :cascade do |t|
    t.string   "company"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.decimal  "costs",      default: 0.0
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.decimal  "price"
    t.integer  "qty"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.string   "order_id"
  end

  add_index "order_items", ["itemable_id"], name: "index_order_items_on_itemable_id"
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",    precision: 10, scale: 2
    t.date     "completed_date"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "delivery_id"
    t.string   "aasm_state"
  end

end

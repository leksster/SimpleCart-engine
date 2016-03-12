# This migration comes from simple_cart (originally 20160312142534)
class Address < ActiveRecord::Migration
  def change
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
  end
end

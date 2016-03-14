class CreateSimpleCartAddress < ActiveRecord::Migration
  def change
    create_table "simple_cart_addresses", force: :cascade do |t|
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

    add_index "simple_cart_addresses", ["order_id"]
  end
end
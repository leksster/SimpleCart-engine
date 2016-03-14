# This migration comes from simple_cart (originally 20160312121928)
class CreateSimpleCartOrderItem < ActiveRecord::Migration
  def change
    create_table "simple_cart_order_items", force: :cascade do |t|
      t.decimal  "price"
      t.integer  "qty"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer  "itemable_id"
      t.string   "itemable_type"
      t.string   "order_id"
    end

    add_index :simple_cart_order_items, :itemable_id
    add_index :simple_cart_order_items, :order_id
  end
end
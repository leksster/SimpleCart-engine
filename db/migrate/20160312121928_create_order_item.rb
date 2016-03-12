class CreateOrderItem < ActiveRecord::Migration
  def change
    create_table "order_items", force: :cascade do |t|
      t.decimal  "price"
      t.integer  "qty"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer  "itemable_id"
      t.string   "itemable_type"
      t.string   "order_id"
    end

    add_index :order_items, :itemable_id
    add_index :order_items, :order_id
  end
end

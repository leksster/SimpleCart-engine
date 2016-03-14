class CreateSimpleCartOrder < ActiveRecord::Migration
  def change
    create_table "simple_cart_orders", force: :cascade do |t|
      t.decimal  "total_price",    precision: 10, scale: 2
      t.date     "completed_date"
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.integer  "delivery_id"
      t.string   "aasm_state"
    end
  end
end
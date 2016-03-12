# This migration comes from simple_cart (originally 20160312124050)
class CreateOrder < ActiveRecord::Migration
  def change
    create_table "orders", force: :cascade do |t|
      t.decimal  "total_price",    precision: 10, scale: 2
      t.date     "completed_date"
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.integer  "shipping_id"
      t.string   "aasm_state"
    end
  end
end

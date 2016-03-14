class CreateSimpleCartDelivery < ActiveRecord::Migration
  def change
    create_table "simple_cart_deliveries", force: :cascade do |t|
      t.string   "company"
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.decimal  "costs",      default: 0.0
    end
  end
end


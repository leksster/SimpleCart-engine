class AddCreditCard < ActiveRecord::Migration
  def change
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
  end
end

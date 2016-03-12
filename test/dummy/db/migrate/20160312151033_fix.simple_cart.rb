# This migration comes from simple_cart (originally 20160312150941)
class Fix < ActiveRecord::Migration
  def change
    rename_column :orders, :shipping_id, :delivery_id
  end
end

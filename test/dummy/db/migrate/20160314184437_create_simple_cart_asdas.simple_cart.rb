# This migration comes from simple_cart (originally 20160314183842)
class CreateSimpleCartAsdas < ActiveRecord::Migration
  def change
    create_table :simple_cart_asdas do |t|
      t.string :asg
      t.string :asgf

      t.timestamps null: false
    end
  end
end

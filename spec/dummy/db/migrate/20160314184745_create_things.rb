class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :name
      t.decimal :price
      t.integer :qty

      t.timestamps null: false
    end
  end
end

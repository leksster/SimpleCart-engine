class CreateKks < ActiveRecord::Migration
  def change
    create_table :kks do |t|
      t.string :name
      t.decimal :price
      t.integer :qty

      t.timestamps null: false
    end
  end
end
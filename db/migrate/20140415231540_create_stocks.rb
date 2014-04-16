class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.references :product, index: true
      t.references :warehouse, index: true

      t.timestamps
    end
  end
end

class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.integer :quantity
      t.references :employee, index: true
      t.references :warehouse, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end

class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.integer :quantity
      t.references :employee, index: true
      t.references :warehouse
      t.references :product

      t.timestamps
    end
  end
end

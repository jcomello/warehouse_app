class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
      t.string :street
      t.string :number
      t.string :complement
      t.string :cep

      t.timestamps
    end
  end
end

require 'spec_helper'

describe HandleStock do
  describe "#add_quantity" do
    let(:stock)  { Stock.find_or_create_by(product_id: "4", warehouse_id: "7") }

    context "first stock" do
      let(:params) { { product_id: "4", warehouse_id: "7", quantity: "8" } }

      it "create an stock with quantity" do
        HandleStock.new(params).add_quantity

        stock.reload.quantity.should eq 8
      end
    end

    context "second stock" do
      let(:first_params)  { { product_id: "4", warehouse_id: "7", quantity: "8" } }
      let(:second_params) { { product_id: "4", warehouse_id: "7", quantity: "13" } }
      let!(:stock)        { Stock.find_or_create_by(first_params) }

      it "adds quantity to stock" do
        HandleStock.new(second_params).add_quantity

        stock.reload.quantity.should eq 21
      end
    end
  end
end

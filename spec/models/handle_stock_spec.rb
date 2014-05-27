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

  describe "#decrease_quantity" do
    context "when quantity is less than amount" do
      let(:first_params)  { { product_id: "4", warehouse_id: "7", quantity: "10" } }
      let(:second_params) { { product_id: "4", warehouse_id: "7", quantity: "3"  } }
      let(:handle_stock)  { HandleStock.new(second_params) }
      let!(:stock)  { Stock.find_or_create_by(first_params) }

      before do
        handle_stock.deacrease_quantity
      end

      it "decreases stock's quantity" do
        stock.reload.quantity.should eq 7
      end

      it "does not set errors" do
        handle_stock.errors.should_not be_present
      end
    end

    context "when quantity is greater than amount" do
      let(:first_params)  { { product_id: "4", warehouse_id: "7", quantity: "10" } }
      let(:second_params) { { product_id: "4", warehouse_id: "7", quantity: "13" } }
      let(:handle_stock)  { HandleStock.new(second_params) }
      let!(:stock)  { Stock.find_or_create_by(first_params) }

      before do
        handle_stock.deacrease_quantity
      end

      it "does not decrease stock's quantity" do
        stock.reload.quantity.should eq 10
      end

      it "sets errors" do
        handle_stock.errors.should be_present
      end

      it "sets correct errors" do
        handle_stock.errors.should eq({ quantity: [I18n.t("activerecord.errors.models.stock.attributes.quantity.greater_than")] })
      end
    end
  end
end

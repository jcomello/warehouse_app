require 'spec_helper'

describe Product do
  describe "#total_count" do
    let(:warehouse) { FactoryGirl.create(:warehouse) }
    let(:product) { FactoryGirl.create(:product) }
    let!(:stock) { FactoryGirl.create(:stock, quantity: 34, product: product, warehouse: warehouse) }

    context "product in one only warehouse" do
      it "counts total quantity" do
        product.total_count.should eq 34
      end
    end

    context "product in more than one warehouse" do
      let(:other_warehouse) { FactoryGirl.create(:warehouse) }
      let!(:other_stock) { FactoryGirl.create(:stock, quantity: 10, product: product, warehouse: other_warehouse) }

      it "counts total quantity" do
        product.total_count.should eq 44
      end
    end
  end
end

# encoding: utf-8
require "spec_helper"

describe "Stocks" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List stocks" do
    context "when there is stocks" do
      let(:warehouse) { FactoryGirl.create(:warehouse) }
      let(:product) { FactoryGirl.create(:product) }
      let!(:stock) { FactoryGirl.create(:stock, product: product, warehouse: warehouse) }

      it "shows stocks" do
        visit stocks_path

        page.should have_content stock.product.name

        page.should have_content stock.quantity

        page.should have_content stock.warehouse.street
        page.should have_content stock.warehouse.number
      end
    end

    context "when there isn't stocks" do
      it "shows no stocks message" do
        visit stocks_path

        page.should have_content I18n.t('stocks.index.no_stocks')
      end
    end
  end
end

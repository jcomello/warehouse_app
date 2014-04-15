# encoding: utf-8
require "spec_helper"

describe "Inputs" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List inputs" do
    context "when there is inputs" do
      let!(:input) { FactoryGirl.create(:input, employee_id: employee.id) }

      it "shows products" do
        visit inputs_path

        page.should have_content employee.name

        page.should have_content input.product.name

        page.should have_content input.quantity

        page.should have_content input.warehouse.street
        page.should have_content input.warehouse.number
      end
    end

    context "when there isn't products" do
      it "shows no products message" do
        visit inputs_path

        page.should have_content I18n.t('inputs.index.no_inputs')
      end
    end
  end
end

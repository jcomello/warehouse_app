# encoding: utf-8
require "spec_helper"

describe "Inputs" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List inputs" do
    context "when there is inputs" do
      let!(:input) { FactoryGirl.create(:input, employee_id: employee.id) }

      it "shows intputs" do
        visit inputs_path

        page.should have_content employee.email

        page.should have_content input.product.name

        page.should have_content input.quantity

        page.should have_content input.warehouse.street
        page.should have_content input.warehouse.number
      end
    end

    context "when there isn't inputs" do
      it "shows no inputs message" do
        visit inputs_path

        page.should have_content I18n.t('inputs.index.no_inputs')
      end
    end
  end

  context "create input" do
    let!(:product)   { FactoryGirl.create(:product) }
    let!(:warehouse) { FactoryGirl.create(:warehouse) }

    let(:input)      { FactoryGirl.build(:input) }

    context "when information are complete" do
      it "create a new input" do
        visit new_input_path

        fill_in 'Quantidade', :with => 3
        select warehouse.street, :from => 'Almoxarifado'
        select product.name,   :from => 'Produto'

        click_button I18n.t('buttons.save')

        page.current_path.should eq inputs_path

        page.should have_content I18n.t('inputs.notice.create_successful')
      end
    end

    context "when information are not complete" do
      it "shows error at new input page" do
        visit new_input_path

        click_button I18n.t('buttons.save')

        page.current_path.should eq inputs_path

        page.should have_content I18n.t('simple_form.error_notification.default_message')
      end
    end
  end
end

# encoding: utf-8
require "spec_helper"

describe "Outputs" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List outputs" do
    context "when there is outputs" do
      let!(:output) { FactoryGirl.create(:output, employee_id: employee.id) }

      it "shows outputs" do
        visit outputs_path

        page.should have_content employee.email

        page.should have_content output.product.name

        page.should have_content output.quantity

        page.should have_content output.warehouse.street
        page.should have_content output.warehouse.number
      end
    end

    context "when there isn't outputs" do
      it "shows no outputs message" do
        visit outputs_path

        page.should have_content I18n.t('outputs.index.no_outputs')
      end
    end
  end

  context "create output" do
    let!(:product)   { FactoryGirl.create(:product) }
    let!(:warehouse) { FactoryGirl.create(:warehouse) }

    let(:output)      { FactoryGirl.build(:output) }

    context "when information are complete" do
      it "create a new output" do
        visit new_output_path

        fill_in 'Quantidade', :with => 3
        select warehouse.street, :from => 'Almoxarifado'
        select product.name,   :from => 'Produto'


        click_button I18n.t('buttons.save')

        page.current_path.should eq outputs_path

        page.should have_content I18n.t('activerecord.errors.models.stock.attributes.quantity.greater_than')
      end
    end

    context "when information are not complete" do
      it "shows error at new output page" do
        visit new_output_path

        click_button I18n.t('buttons.save')

        page.current_path.should eq outputs_path

        page.should have_content I18n.t('simple_form.error_notification.default_message')
      end
    end

    context "when quantity is greater than stock's" do
      let!(:stock) { FactoryGirl.create(:stock) }

      it "shows error at new output page" do
        visit new_output_path

        fill_in 'Quantidade', :with => 56
        select warehouse.street, :from => 'Almoxarifado'
        select product.name,   :from => 'Produto'

        click_button I18n.t('buttons.save')

        page.should have_content I18n.t("activerecord.errors.models.stock.attributes.quantity.greater_than")
      end
    end
  end
end

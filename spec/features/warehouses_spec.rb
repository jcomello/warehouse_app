# encoding: utf-8
require "spec_helper"

describe "CRUD warehouses" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List warehouse" do
    context "when there is warehouse" do
      let!(:warehouse) { FactoryGirl.create(:warehouse) }

      it "shows warehouses" do
        visit warehouses_path

        page.should have_content warehouse.street
        page.should have_content warehouse.number
      end
    end

    context "when there isn't warehouse" do
      it "shows no warehouse message" do
        visit warehouses_path

        page.should have_content I18n.t('warehouses.index.no_warehouses')
      end
    end
  end

  context "Create warehouse" do
    context "when information are complete" do
      it "creates a new warehouse" do
        visit new_warehouse_path

        fill_in 'Rua', :with => 'Av Rio Branco'
        fill_in 'Número', :with => '23'

        click_button I18n.t('buttons.save')

        page.current_path.should eq warehouses_path
        page.should have_content I18n.t('warehouses.notice.create_successful')
      end
    end

    context "when information are not complete" do
      it "shows error at new warehouse page" do
        visit new_warehouse_path

        fill_in 'Rua', :with => 'Av Rio Branco'

        click_button I18n.t('buttons.save')

        page.current_path.should eq warehouses_path

        page.should have_content I18n.t('simple_form.error_notification.default_message')
      end
    end
  end

  context "Edit warehouse" do
    let!(:warehouse) { FactoryGirl.create(:warehouse) }

    context "when information are complete" do
      it "Edits a warehouse" do
        visit edit_warehouse_path(warehouse)

        fill_in 'Rua', :with => 'Av Rio Blanks'

        click_button I18n.t('buttons.save')

        page.current_path.should eq warehouses_path
        page.should have_content I18n.t('warehouses.notice.update_successful')

        within "#warehouse_#{warehouse.id}" do
          page.should have_content 'Av Rio Blanks'
        end
      end
    end
  end

  context "Delete warehouse" do
    let!(:warehouse) { FactoryGirl.create(:warehouse) }

    xit "deletes a warehouse" do
      visit warehouses_path

      within "#warehouse_#{warehouse.id}" do
        click_on I18n.t('warehouses.index.destroy')
      end

      page.should have_no_css "#warehouse_#{warehouse.id}"
    end
  end
end

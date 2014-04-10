# encoding: utf-8
require "spec_helper"

describe "List products" do
  context "when there is products" do
    let(:provider) { FactoryGirl.create(:provider) }
    let!(:product) { FactoryGirl.create(:product, provider_id: provider.id) }

    it "shows products" do
      visit products_path

      page.should have_content product.name
      page.should have_content product.provider.name
    end
  end

  context "when there isn't products" do
    it "shows no products message" do
      visit products_path

      page.should have_content I18n.t('products.index.no_products')
    end
  end

end

describe "Create product" do
  context "when information are complete" do
    let!(:provider) { FactoryGirl.create(:provider) }

    it "creates a new product" do
      visit new_product_path

      fill_in 'Nome', :with => 'Produto 1'
      select provider.name, :from => 'Fornecedor'

      click_button I18n.t('buttons.save')

      page.current_path.should eq products_path

      page.should have_content I18n.t('products.notice.create_successful')
    end
  end

  context "when information are not complete" do
    it "shows error at new product page" do
      visit new_product_path

      click_button I18n.t('buttons.save')

      page.current_path.should eq products_path

      page.should have_content I18n.t('simple_form.error_notification.default_message')
    end
  end
end

describe "Edit product" do
  let(:provider) { FactoryGirl.create(:provider) }
  let!(:product) { FactoryGirl.create(:product, provider_id: provider.id) }

  let!(:other_provider) { FactoryGirl.create(:provider) }

  context "when information are complete" do
    it "Edits a product" do
      visit edit_product_path(product)

      select other_provider.name, :from => 'Fornecedor'

      click_button I18n.t('buttons.save')

      page.current_path.should eq products_path
      page.should have_content I18n.t('products.notice.update_successful')

      within "#product_#{product.id} #provider" do
        page.should have_content other_provider.name
      end
    end
  end
end

describe "Delete product" do
  let(:provider) { FactoryGirl.create(:provider) }
  let!(:product) { FactoryGirl.create(:product, provider_id: provider.id) }

  it "deletes a product" do
    visit products_path

    within "#product_#{product.id}" do
      click_on I18n.t('products.index.destroy')
    end

    page.should have_no_css "#product_#{product.id}"
  end
end

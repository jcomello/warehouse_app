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

      page.should have_content "Não existem produtos salvos"
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

      click_button 'Salvar'

      page.current_path.should eq products_path

      page.should have_content "Produto salvo com sucesso"
    end
  end

  context "when information are not complete" do
    it "shows error at new product page" do
      visit new_product_path

      click_button 'Salvar'

      page.current_path.should eq products_path

      page.should have_content "Por favor revise os erros abaixo"
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

      click_button 'Salvar'

      page.current_path.should eq products_path
      page.should have_content "Produto atualizado com sucesso"

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
      click_on 'Destroy'
    end

    page.should have_no_css "#product_#{product.id}"
  end
end

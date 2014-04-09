# encoding: utf-8
require "spec_helper"

describe "List warehouse" do
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

      page.should have_content "Não existem almoxarifados salvos"
    end
  end
end

describe "Create warehouse" do
  context "when information are complete" do
    it "creates a new warehouse" do
      visit new_warehouse_path

      fill_in 'Rua', :with => 'Av Rio Branco'
      fill_in 'Número', :with => '23'

      click_button 'Salvar'

      page.current_path.should eq warehouses_path
    end
  end

  context "when information are not complete" do
    it "shows error at new warehouse page" do
      visit new_warehouse_path

      fill_in 'Rua', :with => 'Av Rio Branco'

      click_button 'Salvar'

      page.current_path.should eq warehouses_path

      page.should have_content "Existem alguns campos obrigatórios não preenchidos"
    end
  end
end

describe "Edit warehouse" do
  let!(:warehouse) { FactoryGirl.create(:warehouse) }

  context "when information are complete" do
    it "Edits a warehouse" do
      visit edit_warehouse_path(warehouse)

      fill_in 'Rua', :with => 'Av Rio Blanks'

      click_button 'Salvar'

      page.current_path.should eq warehouses_path
      page.should have_content "Almoxarifado atualizado com sucesso"

      # within "#warehouse_#{warehouse.id} #almoxarifado" do
      #   page.should have_content 'Av Rio Blanks'
      # end
    end
  end
end

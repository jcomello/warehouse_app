# encoding: utf-8
require "spec_helper"

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

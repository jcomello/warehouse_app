# encoding: utf-8
require "spec_helper"

describe "List providers" do
  context "when there is providers" do
    let!(:provider) { FactoryGirl.create(:provider) }

    it "shows providers" do
      visit providers_path

      page.should have_content provider.name
    end
  end

  context "when there isn't providers" do
    it "shows no providers message" do
      visit providers_path

      page.should have_content "Não existem fornecedores salvos"
    end
  end
end

describe "Create provider" do
  context "when information are complete" do
    let!(:provider) { FactoryGirl.create(:provider) }

    it "creates a new provider" do
      visit new_provider_path

      fill_in 'Nome', :with => 'Fornecedor 1'

      click_button 'Salvar'

      page.current_path.should eq providers_path

      page.should have_content "Fornecedor salvo com sucesso"
    end
  end

  context "when information are not complete" do
    it "shows error at new provider page" do
      visit new_provider_path

      click_button 'Salvar'

      page.current_path.should eq providers_path

      page.should have_content "Por favor revise os erros abaixo"
    end
  end
end

describe "Edit provider" do
  let!(:provider) { FactoryGirl.create(:provider) }

  context "when information are complete" do
    it "Edits a provider" do
      visit edit_provider_path(provider)

      fill_in 'Nome', :with => 'Fornecedor ahahah'

      click_button 'Salvar'

      page.current_path.should eq providers_path
      page.should have_content "Fornecedor atualizado com sucesso"

      within "#provider_#{provider.id}" do
        page.should have_content 'Fornecedor ahahah'
      end
    end
  end
end

describe "Delete provider" do
  let!(:provider) { FactoryGirl.create(:provider) }

  it "deletes a provider" do
    visit providers_path

    within "#provider_#{provider.id}" do
      click_on 'Destroy'
    end

    page.should have_no_css "#provider_#{provider.id}"
  end
end

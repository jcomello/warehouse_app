# encoding: utf-8
require "spec_helper"

describe "CRUD providers" do
  let(:employee) { FactoryGirl.create(:employee) }
  before { sign_in employee }

  context "List providers" do
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

        page.should have_content I18n.t('providers.index.no_providers')
      end
    end
  end

  context "Create provider" do
    context "when information are complete" do
      let!(:provider) { FactoryGirl.create(:provider) }

      it "creates a new provider" do
        visit new_provider_path

        fill_in 'Nome', :with => 'Fornecedor 1'

        click_button I18n.t('buttons.save')

        page.current_path.should eq providers_path

        page.should have_content I18n.t('providers.notice.create_successful')
      end
    end

    context "when information are not complete" do
      it "shows error at new provider page" do
        visit new_provider_path

        click_button I18n.t('buttons.save')

        page.current_path.should eq providers_path

        page.should have_content I18n.t('simple_form.error_notification.default_message')
      end
    end
  end

  context "Edit provider" do
    let!(:provider) { FactoryGirl.create(:provider) }

    context "when information are complete" do
      it "Edits a provider" do
        visit edit_provider_path(provider)

        fill_in 'Nome', :with => 'Fornecedor ahahah'

        click_button I18n.t('buttons.save')

        page.current_path.should eq providers_path
        page.should have_content I18n.t('providers.notice.update_successful')

        within "#provider_#{provider.id}" do
          page.should have_content 'Fornecedor ahahah'
        end
      end
    end
  end

  context "Delete provider" do
    let!(:provider) { FactoryGirl.create(:provider) }

    it "deletes a provider" do
      visit providers_path

      within "#provider_#{provider.id}" do
        click_on I18n.t('providers.index.destroy')
      end

      page.should have_no_css "#provider_#{provider.id}"
    end
  end
end

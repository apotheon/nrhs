require 'rails_helper'

feature 'Help Text' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }
    let(:help_text) { 'this is text' }
    let(:category) { create :category }
    let!(:test_page) { create :page, category: category }

    before do
      sign_in admin
    end

    scenario 'edits help document' do
      visit edit_help_doc_path
      fill_in 'Help Text', with: help_text
      click_on 'Save Help Text'

      expect(page).to have_content 'Help Text Updated'

      [
        edit_home_path,
        edit_help_doc_path,
        edit_category_path(category),
        edit_page_path(test_page),
        new_category_path,
        new_page_path
      ].each do |form_page|
        visit form_page
        expect(page).to have_content help_text
      end
    end
  end
end

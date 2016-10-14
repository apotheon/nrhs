require 'rails_helper'

feature 'Page' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }

    let(:title) { 'Page Name' }
    let(:body) { 'Body text goes here.' }

    before do
      sign_in admin
    end

    scenario 'views pages dashboard' do
      visit pages_path
      expect(page).to have_content 'Page Management'
    end

    scenario 'creates new page' do
      visit new_page_path
      expect(page).to have_content 'Create New Page'

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      click_on 'Save Page'

      expect(page).to have_content title
      expect(page).to have_content body
    end
  end
end

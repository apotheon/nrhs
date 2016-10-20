require 'rails_helper'

feature 'Page' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }
    let(:title) { 'Page Name' }
    let(:body) { 'Body text goes here.' }

    let!(:pages) { create_list :page, 3 }

    before do
      sign_in admin
    end

    scenario 'views pages dashboard' do
      visit pages_path
      expect(page).to have_content 'Manage Pages'
      pages.each {|site_page| expect(page).to have_link site_page.title }
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

    scenario 'edits existing page' do
      first_title = pages.first.title.clone
      first_body = pages.first.body.clone

      visit page_path pages.first
      expect(page).to have_content first_title
      expect(page).to have_content first_body

      click_on 'Edit Page'
      fill_in 'Body', with: body
      click_on 'Save Page'

      expect(page).to have_content first_title
      expect(page).to have_content body
      expect(page).to_not have_content first_body
    end
  end
end

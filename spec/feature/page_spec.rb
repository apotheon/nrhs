require 'rails_helper'

feature 'Page' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }
    let(:title) { 'Page Name' }
    let(:body) { 'Body text goes here.' }

    let(:category) { create :category }
    let!(:pages) { create_list :page, 3, category: category }

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

      expect do
        fill_in 'Title', with: title
        fill_in 'Body', with: body
        click_on 'Save Page'
      end.to change { Page.where(title: title).count }

      expect(page).to have_content title
      expect(page).to have_content body
    end

    scenario 'tries to create duplicate page' do
      visit new_page_path
      last_title = pages.last.title

      expect do
        fill_in 'Title', with: last_title
        fill_in 'Body', with: body
        click_on 'Save Page'
      end.to_not change { Page.where(title: last_title).count }

      expect(page).to have_content "Page #{last_title} exists."
    end

    scenario 'tries to create a page with no name' do
      visit new_page_path

      fill_in 'Body', with: body
      click_on 'Save Page'

      expect(page).to have_content 'Please supply a page title.'
    end

    scenario 'deletes existing page title' do
      visit edit_page_path pages.first

      fill_in 'Title', with: ''
      click_on 'Save Page'

      expect(page).to have_content 'Please supply a page title.'
    end

    scenario 'deletes an existing page' do
      page_title = pages.last.title

      expect do
        visit page_path pages.last
        click_on 'Delete Page'

        expect(page).to have_content 'Page Deleted'
        expect(Page.find_by title: page_title).to be_nil
      end.to change { Page.all.size }.by -1
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

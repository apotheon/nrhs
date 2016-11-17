require 'rails_helper'

feature 'Authorization' do
  context 'logged in admin' do
    let(:admin) { create :user, :admin }

    before do
      sign_in admin
    end

    context 'visiting home index page' do
      let(:category_name) { 'Headwork' }
      let(:category_body) { 'This is category body text.' }

      scenario 'visits account page' do
        expect(admin.admin?).to be_truthy

        click_on 'Account Settings'
        expect(page).to have_content 'Edit Account Settings'

        ['Manage Categories', 'Manage Pages'].each do |link_text|
          expect(page).to have_link link_text
          click_on link_text
          expect(page).to have_selector 'h2', text: link_text
        end
      end

      scenario 'creates a category' do
        visit categories_path
        click_on 'New Category'

        fill_in 'Category Name', with: category_name
        fill_in 'Body', with: category_body
        click_on 'Save Category'

        expect(page).to have_selector 'h2', text: category_name
        expect(page).to have_content category_body
        expect(page).to have_content 'Category Created'
      end

      context 'with existing category' do
        let!(:existing_category) do
          create :category, name: category_name, body: category_body
        end

        let(:page_title) { 'Port, Polish, Deck' }
        let(:page_body) { 'This is page body text.' }

        scenario 'creates a page' do
          visit pages_path
          click_on 'New Page'

          fill_in 'Title', with: page_title
          fill_in 'Body', with: page_body
          click_on 'Save Page'

          expect(page).to have_selector 'h2', text: page_title
          expect(page).to have_content page_body
          expect(page).to have_content 'Page Created'
        end
      end
    end
  end

  context 'visitor' do
    scenario 'visits home index page' do
      [
        'Account Settings', 'Manage Categories', 'Manage Pages'
      ].each do |link_text|
        expect(page).to_not have_link link_text
      end
    end
  end
end

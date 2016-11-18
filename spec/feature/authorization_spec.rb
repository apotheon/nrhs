require 'rails_helper'

feature 'Authorization' do
  let(:category_name) { 'Headwork' }
  let(:category_body) { 'This is category body text.' }

  let(:page_title) { 'Port, Polish, Deck' }
  let(:page_body) { 'This is page body text.' }

  context 'logged in admin' do
    let(:admin) { create :user, :admin }

    before do
      sign_in admin
    end

    context 'visiting home index page' do
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
        'Account Settings', 'Edit Homepage',
        'Manage Categories', 'Manage Pages'
      ].each do |link_text|
        expect(page).to_not have_link link_text
      end
    end

    scenario 'attempts to edit homepage' do
      visit edit_home_path
      expect(page).to have_content 'not authorized'
      expect(current_path).to_not eq edit_home_path
    end

    scenario 'attempts to visit categories index' do
      visit categories_path

      expect(page).to have_content 'not authorized'
      expect(page).to_not have_selector 'h2', text: 'Manage Categories'
      expect(page).to_not have_link 'New Category'
    end

    scenario 'attempts to create category' do
      visit new_category_path

      expect(page).to have_content 'not authorized'
      expect(page).to_not have_selector 'h2', text: 'Create New Category'
    end

    scenario 'attempts to visit pages index' do
      visit pages_path

      expect(page).to have_content 'not authorized'
      expect(page).to_not have_selector 'h2', text: 'Manage Pages'
      expect(page).to_not have_link 'New Page'
    end

    context 'with existing category' do
      let!(:existing_category) do
        create :category, name: category_name, body: category_body
      end

      scenario 'attempts to edit category' do
        visit edit_category_path existing_category

        expect(page).to have_content 'not authorized'
        expect(page).to_not have_selector 'h2', text: 'Edit Category'
      end

      scenario 'attempts to create page' do
        visit new_page_path

        expect(page).to have_content 'not authorized'
        expect(page).to_not have_selector 'h2', text: 'Create New Page'
      end

      context 'with existing page' do
        let!(:existing_page) do
          create :page,
          title: page_title, body: page_body,
          category: existing_category
        end

        scenario 'attempts to edit page' do
          visit edit_page_path existing_page

          expect(page).to have_content 'not authorized'
          expect(page).to_not have_selector 'h2', text: 'Edit Page'
        end
      end
    end
  end
end

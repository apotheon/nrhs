require 'rails_helper'

feature 'Category' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }
    let(:title_text) { 'This Title' }
    let(:category_name) { 'Engine Kits' }
    let(:body_text) { 'This is the body.  Here you go.' }

    before do
      sign_in admin
    end

    scenario 'creates page with new category' do
      visit new_page_path

      fill_in 'Title', with: title_text
      fill_in 'Category', with: category_name
      fill_in 'Body', with: body_text
      click_on 'Save Page'

      expect(page).to have_content category_name
    end

    context 'with existing page' do
      let(:page) { create :page, category: category_name }
      let(:new_category_name) { 'Headwork' }

      pending 'creates page with existing category' do
        visit new_page_path

        fill_in 'Title', with: title_text
        fill_in 'Category', with: category_name
        fill_in 'Body', with: body_text
        click_on 'Save Page'

        expect(page).to have_content category_name

        visit page_path page
        expect(page).to have_content category_name

        visit categories_path
        expect(page).to have_content category_name
      end

      pending 'changes category of page' do
        visit page_path page

        fill_in 'Category', with: new_category_name
        click_on 'Save Page'

        expect(page).to have_content new_category_name

        visit categories_path
        expect(page).to have_content new_category_name
      end
    end
  end
end

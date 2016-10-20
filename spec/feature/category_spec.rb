require 'rails_helper'

feature 'Category' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }
    let(:title_text) { 'This Title' }
    let(:category_name) { 'Kite Kits' }
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

      expect(page).to have_link category_name
    end

    context 'with existing page' do
      let(:category) { create :category, name: 'Headwork' }
      let(:existing_page) { create :page, category_id: category.id }

      scenario 'creates page with existing category' do
        visit new_page_path

        fill_in 'Title', with: title_text
        fill_in 'Category', with: category.name
        fill_in 'Body', with: body_text
        click_on 'Save Page'

        new_page = Page.find_by title: title_text

        expect(new_page.category.name).to eq category.name
        expect(existing_page.category.name).to eq category.name

        expect(Page.all.size).to eq 2
      end

      scenario 'changes category of page' do
        new_category_name = 'Engine Kits'

        visit edit_page_path existing_page

        fill_in 'Category', with: new_category_name
        click_on 'Save Page'

        expect(page).to have_link new_category_name
        expect(page).to_not have_link category.name
      end
    end

    context 'with multiple categories' do
      let(:categories) { create_list :category, 3 }
      let!(:pages_1) { create_list :page, 1, category: categories[0] }
      let!(:pages_2) { create_list :page, 2, category: categories[1] }
      let!(:pages_3) { create_list :page, 3, category: categories[2] }

      let(:category_regex) do
        categories.map {|category| category.name }.sort.join '.*'
      end

      let(:third_cat_pages_regex) do
        pages_3.map {|page| "Title: #{page.title}" }.sort.join '.*'
      end

      scenario 'views category index' do
        visit categories_path

        expect(page).to have_content 'Categories'
        expect(page.text).to match category_regex
      end

      scenario 'visits third category view' do
        visit categories_path
        click_on "view #{categories.last.name}"

        expect(page).to have_content "Category: #{categories.last.name}"
        expect(page.text).to match third_cat_pages_regex
      end
    end
  end
end

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

    scenario 'tries creating new page without existing category' do
      visit new_page_path

      expect(page).to have_content 'Please create a category.'
      expect(current_path).to eq new_category_path
    end

    scenario 'creates a category' do
      visit root_path
      click_on 'Manage Categories'
      click_on 'New Category'

      expect do
        fill_in 'Category Name', with: category_name
        fill_in 'Body', with: body_text
        click_on 'Save Category'
      end.to change { Category.where(name: category_name).count }

      expect(Category.first.name).to eq category_name
      expect(page).to have_content body_text
    end

    scenario 'tries to create category without name' do
      visit new_category_path

      fill_in 'Body', with: body_text
      click_on 'Save Category'

      expect(page).to have_content 'Please supply a category name.'
    end

    context 'with existing page' do
      let(:category) { create :category, name: 'Headwork' }
      let!(:new_category) { create :category, name: 'Engine Kits' }
      let!(:existing_page) { create :page, category_id: category.id }
      let!(:category_name) { category.name }

      scenario 'deletes category' do
        expect do
          visit category_path category
          click_on 'Delete Category'
        end.to change { Page.all.size }.by -1
      end

      scenario 'changes category name' do
        visit category_path category
        click_on 'Edit Category'

        fill_in 'Category Name', with: 'Bob White'
        click_on 'Save Category'

        expect(page).to have_content 'Bob White'
        expect(page).to_not have_content category_name
      end

      scenario 'tries to create duplicate category' do
        visit new_category_path

        expect do
          fill_in 'Category Name', with: category.name
          fill_in 'Body', with: body_text
          click_on 'Save Category'
        end.to_not change { Category.where(name: category.name).count }

        expect(page).to have_content "Category #{category.name} exists."
      end

      scenario 'creates page with existing category' do
        visit new_page_path

        fill_in 'Title', with: title_text
        select category.name, from: 'Category'
        fill_in 'Body', with: body_text
        click_on 'Save Page'

        new_page = Page.find_by title: title_text

        expect(new_page.category.name).to eq category.name
        expect(existing_page.category.name).to eq category.name

        expect(Page.all.size).to eq 2
      end

      scenario 'changes category of page' do
        visit edit_page_path existing_page

        select new_category.name, from: 'Category'
        click_on 'Save Page'

        expect(page).to have_link new_category.name
        expect(page).to_not have_link category.name
      end

      scenario 'deletes existing category name' do
        visit edit_category_path category

        fill_in 'Name', with: ''
        click_on 'Save Category'

        expect(page).to have_content 'Please supply a category name.'
      end
    end

    context 'with multiple categories' do
      let(:categories) { create_list :category, 4 }
      let!(:pages_1) { create_list :page, 1, category: categories[1] }
      let!(:pages_2) { create_list :page, 2, category: categories[2] }
      let!(:pages_3) { create_list :page, 3, category: categories[3] }

      let(:category_regex) do
        categories.map {|category| category.name }.sort.join '.*'
      end

      let(:third_cat_pages_regex) do
        pages_3.map {|page| page.title }.sort.join '.*'
      end

      let(:active_category_regex) do
        categories[1..3].map {|category| category.name }.sort.join '.*'
      end

      scenario 'views home page' do
        visit root_path
        expect(page.text).to match active_category_regex
      end

      scenario 'views category index' do
        visit categories_path

        expect(page).to have_content 'Categories'
        expect(page.text).to match category_regex
      end

      scenario 'visits third category view' do
        visit categories_path
        click_on "view #{categories.last.name}"

        expect(page).to have_selector 'h2', text: categories.last.name
        expect(page.text).to match third_cat_pages_regex
      end

      scenario 'deletes inactive category' do
        category_name = categories.first.name
        page_number = Page.all.size

        expect do
          visit category_path categories.first
          click_on 'Delete Category'

          visit categories_path
          expect(page).to_not have_content category_name
        end.to change { Category.all.size }.by -1

        expect(Page.all.size).to eq page_number
      end
    end
  end
end

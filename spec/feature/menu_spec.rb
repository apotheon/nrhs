require 'rails_helper'

feature 'Menus' do
  context 'with two categories' do
    let(:categories) { create_list :category, 2 }

    let!(:first_pages) { create_list :page, 3, category: categories.first }
    let(:first_pages_menu_regex) do
      [
        categories.first.name,
        first_pages.map {|p| p.title }.sort
      ].flatten.join '.*'
    end

    let!(:last_pages) { create_list :page, 5, category: categories.last }
    let(:last_pages_menu_regex) do
      [
        categories.last.name,
        last_pages.map {|p| p.title }.sort
      ].flatten.join '.*'
    end

    let(:all_pages) do
      [first_pages, last_pages].flatten
    end

    scenario 'logged out user views menus' do
      visit root_path

      expect(page.text).to match first_pages_menu_regex
      expect(page.text).to match last_pages_menu_regex
    end

    scenario 'logged out user visits pages via menu links' do
      visit root_path

      all_pages.each do |p|
        click_on p.title
        expect(page).to have_content p.body
      end
    end
  end
end

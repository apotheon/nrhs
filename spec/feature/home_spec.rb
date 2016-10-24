require 'rails_helper'

feature 'Home Index' do
  context 'home index page' do
    before do
      visit root_path
    end

    scenario 'shows header navigation' do
      ['Where To Buy', 'Contact Us'].each do |link_text|
        expect(page).to have_link link_text
      end
    end

    scenario 'shows content title' do
      expect(page).to have_content 'Did you know . . . ?'
    end

    scenario 'shows main content' do
      expect(page).to have_content 'NRHS is based in the beautiful city of'
    end

    context 'logged in admin' do
      let(:admin) { create :user, :admin }
      let(:title_text) { 'This Is A Title' }
      let(:body_text) do
        "This is a body; there are many like it, but this body is mine."
      end

      before do
        sign_in admin
      end

      scenario 'edits home page text', focus: true do
        visit root_path
        click_on 'Edit Homepage'

        fill_in 'Title', with: title_text
        fill_in 'Body', with: body_text
        click_on 'Save Homepage'

        expect(page).to have_content title_text
        expect(page).to have_content body_text
      end
    end
  end
end

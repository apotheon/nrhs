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
  end
end

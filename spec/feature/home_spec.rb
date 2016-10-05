require 'rails_helper'

feature 'Home Index' do
  describe 'home index page' do
    before do
      visit root_path
    end

    scenario 'shows header navigation' do
      expect(page).to have_content ['Where To Buy', 'Contact Us'].join ' '
    end

    scenario 'shows main navigation' do
      expect(page).to have_content [
        'Headwork', 'Engine Kits', 'Machine Work', 'Services',
        'Parts', 'Racing', 'Tech Tips', 'Specials'
      ].join ' '
    end

    scenario 'shows content title' do
      expect(page).to have_content 'Did you know . . . ?'
    end

    scenario 'shows main content' do
      expect(page).to have_content 'NRHS is based in the beautiful city of'
    end
  end
end

require 'rails_helper'

feature 'Admin Account' do
  context 'visiting home index page' do
    before do
      visit root_path

      click_on 'Sign Up'
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'
    end

    scenario 'admin signs up' do
      expect(current_path).to eql '/'
    end

    scenario 'admin visits account page' do
      click_on 'Account Settings'
      expect(page).to have_content 'Edit Account Settings'
    end
  end
end

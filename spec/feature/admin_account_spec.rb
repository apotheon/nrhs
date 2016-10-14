require 'rails_helper'

feature 'Admin Account' do
  context 'visiting home index page' do
    let(:admin) { create :user, :admin }

    scenario 'admin visits account page' do
      sign_in admin
      expect(admin.admin?).to be_truthy

      click_on 'Account Settings'
      expect(page).to have_content 'Edit Account Settings'
    end
  end
end

require 'rails_helper'

feature 'Images' do
  context 'logged in admin' do
    let(:admin) { create :user, :admin }

    before do
      sign_in admin
    end

    scenario 'visits the image management page' do
      visit root_path
      click_on 'Manage Images'

      expect(page).to have_selector 'h2', text: 'Manage Images'
    end

    scenario 'uploads an image' do
      visit images_path
      click_on 'New Image'

      expect(page).to have_selector 'h2', text: 'Upload New Image'
    end
  end

  context 'logged out user' do
    scenario 'cannot view the images index' do
      visit images_path
      expect(page.text).to match 'You are not authorized to perform that action.'
      expect(current_path).to eq root_path
    end
  end
end

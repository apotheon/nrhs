require 'rails_helper'

feature 'Home Index' do
  scenario 'visiting the home index page' do
    visit root_path
    expect(page).to have_content 'NRHS V-Twin Performance'
  end
end

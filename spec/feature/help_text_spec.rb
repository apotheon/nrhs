require 'rails_helper'

feature 'Help Text' do
  context 'signed in admin' do
    let(:admin) { create :user, :admin }

    before do
      sign_in admin
    end

    scenario '' do
    end
  end
end

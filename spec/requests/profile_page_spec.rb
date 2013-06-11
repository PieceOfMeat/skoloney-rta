require 'spec_helper'

describe "profile page" do
    before { visit user_path(user) }
    let(:user) { FactoryGirl.create(:user) }

    it "must have proper title and contents" do
      expect(page).to have_selector('h1', text: user.login)
      expect(page).to have_selector('h1 img.gravatar')

      expect(page).to have_content(user.email)

      expect(page).to have_content('02.09.1986')

      expect(page).to have_selector('div.map_container')
    end
  end
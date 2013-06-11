require 'spec_helper'
require 'capybara/rspec'

describe "profile edit page" do
  let(:user) { FactoryGirl.create(:user) }
  before { visit edit_user_path(user) }

    it "must have appropriate header and map" do
      expect(page).to have_selector('h1', :text => 'Edit profile')
      expect(page).to have_selector('div.map_container')
    end

    it "must not have login, email, password and pass_confirm fields" do
      expect(page).not_to have_selector('label', :text => 'Email')
      expect(page).not_to have_selector('label', :text => 'Login')
      expect(page).not_to have_selector('label', :text => 'Password')
      expect(page).not_to have_selector('label', :text => 'Password confirmation')
      expect(page).to have_selector('label', :text => 'Full name')
    end

    it "must have 'Update profile' button instead of 'Sign up!'" do
      expect(page).not_to have_selector('input[value="Sign up!"]')
      expect(page).to have_selector('input[value="Update profile"]')
    end

    it "must change user attributes upon saving" do
      fill_in "Full name", :with => "Sergey"
      click_on "Update profile"
      expect(user.reload.full_name).to be == "Sergey"
    end
  end
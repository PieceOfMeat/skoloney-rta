require 'spec_helper'

describe 'Auth rights' do

  context 'anonimous user' do
    before { visit root_path }

    it "should see links to home page, signup, signin and list of users" do
      expect(page).to have_link('Home Page')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Users list')
    end

    it "should not see links to user profile and signout" do
      expect(page).not_to have_link('Profile')
      expect(page).not_to have_link('Settings')
      expect(page).not_to have_link('Sign out')
    end

  end

  context 'signed in user' do
    before do
      user = FactoryGirl.create(:user)
      visit signin_path
      fill_in "Login/Email", :with => user.login
      fill_in "Password", :with => user.password

      click_button "Sign in"
    end

    it "should see links to list of users, user profile and signout" do
      expect(page).to have_link('Profile')
      expect(page).to have_link('Settings')
      expect(page).to have_link('Sign out')
      expect(page).to have_link('Users list')
    end

    it "should not see contain links to signin and signup" do
      expect(page).not_to have_link('Sign up')
      expect(page).not_to have_link('Sign in')
    end
  end

end
  
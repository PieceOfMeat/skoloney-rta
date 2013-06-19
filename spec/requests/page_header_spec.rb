require 'spec_helper'

describe 'Page header' do

  def expect_header_to_have_link ln
    expect(page).to have_selector('header a', :text => ln)
  end

  def expect_header_not_to_have_link ln
    expect(page).not_to have_selector('header a', :text => ln)
  end

  context 'for anonymous user' do

    before { visit root_path }

    it "should have links to home page, signup, signin and list of users" do
      expect_header_to_have_link 'Home page'
      expect_header_to_have_link 'Sign up'
      expect_header_to_have_link 'Sign in'
      expect_header_to_have_link 'Users list'
      expect_header_to_have_link 'Advertisements'
    end

    it "should not have links to user profile and signout, advert creation" do
      expect_header_not_to_have_link 'Profile'
      expect_header_not_to_have_link 'Edit profile'
      expect_header_not_to_have_link 'Sign out'
    end

  end

  context 'for signed in user' do
    before do
      user = FactoryGirl.create(:user)
      visit signin_path
      fill_in "Login/Email", :with => user.login
      fill_in "Password", :with => user.password

      click_button "Sign in"
    end

    it "should have links to list of users, user profile and signout" do
      expect_header_to_have_link 'Profile'
      expect_header_to_have_link 'Edit profile'
      expect_header_to_have_link 'Sign out'
      expect_header_to_have_link 'Users list'
      expect_header_to_have_link 'Advertisements'
    end

    it "should not have links to signin and signup" do
      expect_header_not_to_have_link 'Sign up'
      expect_header_not_to_have_link 'Sign in'
    end
  end

end
  
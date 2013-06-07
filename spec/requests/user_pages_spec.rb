require 'spec_helper'
require 'capybara/rspec'

describe "UserPages" do
  #subject { page }

  describe "home page" do
    before { visit root_path }

    it "must have proper header" do
      expect(page).to have_selector('a.brand', :text => 'Advert system')
      expect(page).to have_selector('a', :text => 'Home Page')
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it "must have proper title and fields" do
      expect(page).to have_selector('h1', :text => 'Sign Up')
    end
  end

  describe "profile page" do
    before { visit user_path(user) }
    let(:user) { FactoryGirl.create(:user) }

    it "must have proper title and contents" do
      expect(page).to have_selector('h1', text: user.login)
      expect(page).to have_selector('h1 img.gravatar')

      expect(page).to have_content(user.email)

      expect(page).to have_content('02.09.1986')
    end
  end

end
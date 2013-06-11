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

end
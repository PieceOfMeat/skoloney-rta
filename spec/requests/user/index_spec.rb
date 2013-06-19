require 'spec_helper'

describe "Users list page" do

  context "for anonimous user" do
    before do
      @user = FactoryGirl.create :user
      visit users_path
    end

    it "should have list of users" do
      expect(page).to have_selector('td', :text => @user.full_name)
    end

    it "should not have edit or delete links" do
      expect(page).not_to have_selector('a[title="Edit"]')
      expect(page).not_to have_selector('a[title="Delete"]')
    end
  end

  context ""

end
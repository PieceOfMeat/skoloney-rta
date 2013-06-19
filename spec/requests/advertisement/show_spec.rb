require 'spec_helper'

describe 'Advertisement show page' do

  def expect_to_have_management_links
    expect(page).to have_selector('.commands a', :text => 'Edit')
    expect(page).to have_selector('.commands a', :text => 'Destroy')
  end

  def expect_not_to_have_management_links
    expect(page).not_to have_selector('.commands a', :text => 'Edit')
    expect(page).not_to have_selector('.commands a', :text => 'Destroy')
  end

  before do
    @user = FactoryGirl.create :user
    @another_user = FactoryGirl.create :user, :email => 'ok@ok.com', :login => 'ok'
    @ad = FactoryGirl.create :advertisement, :user => @user
  end

  context "for anonymous user" do
    before { visit advertisement_path(@ad) }

    it "must have appropriate heading" do
      expect(page).to have_selector('h1', :text => 'Advertisement')
    end

    it "must have advertisement text" do
      expect(page).to have_content(@ad.content)
    end

    it "must not have edit or destroy link" do
      expect_not_to_have_management_links
    end

  end

  context "for authenticated user" do
    before do
      sign_in @user
      visit advertisement_path(@ad)
    end

    it "should have edit and destroy links" do
      expect_to_have_management_links
    end
  end

  context "for authenticated non-owner of ad" do
    before do
      sign_in @another_user
      visit advertisement_path(@ad)
    end

    it "should not have edit and destroy links" do
      expect_not_to_have_management_links
    end
  end
end
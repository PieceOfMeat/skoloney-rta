require 'spec_helper'

describe 'Advertisement listing page' do

  def expect_to_have_management_links
    expect(page).to have_selector('#adslist li a', :text => 'Edit')
    expect(page).to have_selector('#adslist li a', :text => 'Destroy')
  end

  def expect_not_to_have_management_links
    expect(page).not_to have_selector('#adslist li a', :text => 'Edit')
    expect(page).not_to have_selector('#adslist li a', :text => 'Destroy')
  end

  before(:all) do
    @user = FactoryGirl.create :user
    30.times { FactoryGirl.create :advertisement, :user => @user }
  end


  context "for anonymous users" do
    before { visit advertisements_path }

    it "should contain 10 ads per page" do
      expect(page).to have_selector('#adslist li', :text => 'Post 1')
      expect(page).to have_selector('#adslist li', :text => "Post #{AdvertisementsController::PER_PAGE}")
      expect(page).not_to have_selector('#adslist li', :text => "Post #{AdvertisementsController::PER_PAGE + 1}")
    end

    it "should contain pagination" do
      expect(page).to have_selector('div.pagination')
    end

    it "should not contain links for editing or deleting" do
      expect_not_to_have_management_links
    end

    it "should contain link to show post" do
      expect(page).to have_selector('#adslist li a', :text => 'Show')
    end

    it "should not contain link to new advertisement" do
      expect(page).not_to have_link('New Advertisement')
    end
  end

  context "for authenticated users" do
    it "should show edit and destroy links for owner of ad" do
      sign_in @user
      visit advertisements_path
      expect_to_have_management_links
    end

    it "should not show edit and destroy links for another user" do
      another_user = FactoryGirl.create(:user, :email => 'ok@ok.com', :login => 'ok')
      sign_in another_user
      visit advertisements_path
      expect_not_to_have_management_links
    end

    it "should have link to new advertisement" do
      sign_in @user
      visit advertisements_path
      expect(page).to have_link('New Advertisement')
    end
  end


  after(:all) do
    User.delete_all
    Advertisement.delete_all
  end
end
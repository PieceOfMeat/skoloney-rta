require 'spec_helper'

describe 'Edit advertisement page' do

  before do
    @user = FactoryGirl.create(:user)
    @ad = FactoryGirl.create :advertisement, :user => @user, :content => 'Initial content'
  end

  it "should not be available for anonymous users" do
    visit edit_advertisement_path(@ad)
    expect(current_path).to be == signin_path
    expect(page).to have_selector('.alert', :text => ApplicationController::NOT_AUTHENTICATED_MESSAGE)
  end

  context "for authenticated user" do
    before do
      sign_in @user
      visit edit_advertisement_path(@ad)
    end

    it "should contain proper header and fields" do
      expect(page).to have_selector('h1', :text => 'Edit Advertisement')
      expect(page).to have_selector('label', :text => 'Content')
      expect(page).to have_selector('label', :text => 'Picture')
      expect(page).to have_selector('input[value="Save"]')
    end

    it "should update advertisement for current user" do
      fill_in 'Content', :with => 'New advertisement text'
      click_button 'Save'

      expect(@user.advertisements.count).to be == 1
      expect(@user.advertisements[0].content).to be == 'New advertisement text'
      expect(current_path).to be == advertisement_path(@user.advertisements[0])
    end
  end

  context "if user is not owner of the ad" do
    before do
      another_user = FactoryGirl.create(:user, :email => 'ok@ok.ok', :login => 'ok')
      sign_in another_user
    end

    example "page should not be available" do
      visit edit_advertisement_path(@ad)

      expect(current_path).to be == root_path
      expect(page).to have_selector('.alert', :text => ApplicationController::NOT_AUTHORIZED_MESSAGE)
    end

    example "put request should not be available" do
      put advertisement_path(@ad)
      expect(response).to redirect_to(root_path)
    end

    example "delete request should not be available" do
      delete advertisement_path(@ad)
      expect(response).to redirect_to(root_path)
    end
  end
end
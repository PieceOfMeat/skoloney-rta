require 'spec_helper'

describe 'New advertisement page' do

  it "should not be available for anonymous users" do
    visit new_advertisement_path
    expect(current_path).to be == signin_path
  end

  context "for authenticated user" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      visit new_advertisement_path
    end

    it "should contain proper header and fields" do
      expect(page).to have_selector('h1', :text => 'New Advertisement')
      expect(page).to have_selector('label', :text => 'Content')
      expect(page).to have_selector('input[type="file"]')
      expect(page).to have_selector('input[value="Save"]')
    end

    it "should create new advertisement for current user" do
      fill_in 'Content', :with => 'New advertisement text'
      attach_file('Picture', "#{Rails.root}/spec/files/valid_ad_picture.jpg")
      click_button 'Save'

      expect(@user.advertisements.count).to be == 1
      ad = @user.advertisements[0]
      expect(ad.content).to be == 'New advertisement text'
      expect(ad).to have_attached_file(:picture)
      expect(ad.picture.url.include? 'valid_ad_picture').to be_true
      expect(current_path).to be == advertisement_path(@user.advertisements[0])
    end

    it "should show validation errors upon blank content" do
      click_button 'Save'
      expect(page).to have_selector('h1', :text => 'New Advertisement')
      expect(page).to have_selector('div.alert.alert-error')
    end
  end
end
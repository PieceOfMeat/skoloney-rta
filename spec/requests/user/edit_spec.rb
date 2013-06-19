require 'spec_helper'

describe "profile edit page" do

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    visit edit_user_path(@user)
  end

  it "must have appropriate header and map" do
    expect(page).to have_selector('h1', :text => 'Edit Profile')
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
    expect(page).to have_selector('input[value="Edit Profile"]')
  end

  it "must change user attributes upon saving" do
    fill_in "Full name", :with => "Sergey"
    click_button "Edit Profile"
    expect(@user.reload.full_name).to be == "Sergey"
  end
end
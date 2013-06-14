require 'spec_helper'

describe "signin page" do

  before do
    @user = FactoryGirl.create :user
    visit signin_path
  end

  it "must have correct title" do
    expect(page).to have_selector('h1', :text => 'Sign in')
  end

  it "must have password recovery link" do
    expect(page).to have_selector("a[href='#{password_recovery_path}']", :text => 'Forgot your password?')
  end

  it "must have login/email and password inputs" do
    expect(page).to have_selector('label', :text => 'Login/Email')
    expect(page).to have_selector('label', :text => 'Password')
    expect(page).to have_selector('input[value="Sign in"]')
  end

  it "must show errors if provided incorrect login/password" do
    fill_in 'Login/Email', :with => '123'
    fill_in 'Password', :with => '123'
    click_button "Sign in"

    expect(page).to have_selector('h1', :text => 'Sign in')
    expect(page).to have_selector(
      'div.alert.alert-error',
      :text => SessionsController::INVALID_LOGIN_PASSWORD_MESSAGE
    )
  end

  context "correct authorisation" do
    before do
      fill_in 'Login/Email', :with => @user.login
      fill_in 'Password', :with => @user.password
      click_button "Sign in"
    end

    it "must redirect user to his profile page" do
      expect(current_path).to be == user_path(@user)
    end
  end
end
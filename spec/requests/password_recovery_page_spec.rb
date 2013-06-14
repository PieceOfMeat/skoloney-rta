require 'spec_helper'

describe "Password recovery page" do
  
  before do
    ActionMailer::Base.deliveries = []
    @user = FactoryGirl.create :user
    visit password_recovery_path
  end

  it "should contain proper header and form fields" do
    expect(page).to have_selector('h1', :text => 'Password recovery')
    expect(page).to have_selector('label', :text => 'Your login or email')
  end

  it "should show an error if provided nonexistent login or email" do
    click_on "Recover password"

    expect(page).to have_selector(
      'div.alert.alert-error',
      :text => UsersController::NONEXISTENT_LOGIN_EMAIL_MESSAGE)

    expect(current_path).to be == password_recovery_path
  end

  context "with correct email or login" do

    before do
      fill_in "Your login or email", :with => 'pieCeofMeat'
      click_on "Recover password"
    end

    it "should redirect to signin page page with appropriate notice" do
      expect(current_path).to be == signin_path
      expect(page).to have_selector(
        'div.alert.alert-error',
        :text => UsersController::PASSWORD_RECOVERY_EMAIL_SENT_MESSAGE)
    end

    it "should change user password and he will be able to log in with it" do
      expect(@user.reload.authenticate('123456')).not_to be_true
      matches = ActionMailer::Base.deliveries.first.body.to_s.scan /Here it is:\s*<b>([a-z]{8})/
      new_pass = matches.first.first

      expect(@user.reload.authenticate(new_pass)).to be_true
    end

  end

end
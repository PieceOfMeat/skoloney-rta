require 'spec_helper'

describe "signup page" do
  before { visit signup_path }

  it "must have proper title and fields" do
    expect(page).to have_selector('h1', :text => 'Sign Up')
    expect(page).to have_selector('input[value="Sign up!"]')
  end

  it "must have password and password_confirm fields" do
    expect(page).to have_selector('label', :text=> 'Password')
    expect(page).to have_selector('label', :text=> 'Password confirmation')
  end

  context "with invalid data" do
    it "must not pass validation" do
      click_on "Sign up!"
      expect(page).to have_selector('li', :text => "Email can't be blank")
      expect(page).to have_selector('span', :text => "can't be blank")
    end

    it "must not create a user" do
      expect { click_on "Sign up!" }.not_to change(User, :count)
    end
  end

  context "with valid data" do

    before do
      fill_in "Login", :with => "Pieceofmeat"
      fill_in "Email", :with => "sergey.koloney@gmail.com"
      fill_in "Full name", :with => "Sergey Koloney"

      fill_in "Password", :with => '123456'
      fill_in "Password confirmation", :with => '123456'

      fill_in "Country", :with => "Ukraine"
      fill_in "State", :with => "Donetsk"
      fill_in "City", :with => "Donetsk"
      fill_in "Address", :with => "Sanatornanya, 9/2"
      fill_in "Zip", :with => "83062"
    end

    it "must create new user instance" do
      expect { click_on "Sign up!" }.to change(User, :count).by(1)
    end

    it "must redirect user to profile page and show appropriate notice" do
      click_on "Sign up!"
      expect(current_path).to be == user_path(User.last)
      expect(page).to have_selector(
        '#notice',
        :text => UsersController::USER_PROFILE_CREATED_MESSAGE
      )
    end

  end

end
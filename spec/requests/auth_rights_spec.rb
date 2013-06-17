require 'spec_helper'

describe 'Authorization' do
  before { @user = FactoryGirl.create :user }

  context "for anonymous users" do

    context "enable" do

      example "home page" do
        visit root_path
        expect(page).to have_selector('h1', :text => 'Home Page')
      end

      example "users list" do
        visit users_path
        expect(page).to have_selector('h1', :text => 'Users List')
      end

      example "user profile" do
        visit user_path @user
        expect(page).to have_selector('h1', :text => @user.login)
      end

      example "signup" do
        visit signup_path
        expect(page).to have_selector('h1', :text => 'Sign Up')
      end

      example "signin" do
        visit signin_path
        expect(page).to have_selector('h1', :text => 'Sign In')
      end
    end

    context "disable" do

      example "access for user edit page" do
        visit edit_user_path(@user)
        expect(page).to have_selector('h1', :text => 'Sign In')
        expect(page).to have_selector(
          '.alert.alert-error',
          :text => ApplicationController::NOT_AUTHENTICATED_MESSAGE)
      end

      example "request to the update action" do
        put user_path(@user)
        expect(response).to redirect_to(signin_path)
      end

      example "request to the delete action" do
        delete user_path(@user)
        expect(response).to redirect_to(signin_path)
      end

      example "access to signout" do
        delete signout_path
        expect(response).to redirect_to(signin_path)
      end

    end
  end

  context "for signed in users" do
    before do
      sign_in @user
      @another_user = FactoryGirl.create(:user, :email => 'pieceofmeat@yandex.ru', :login => 'skoloney')
    end

    context "enable" do

      example "access to self update action" do
        visit edit_user_path(@user)
        expect(current_path).to be == edit_user_path(@user)
        expect(page).to have_selector('h1', :text => 'Edit Profile')
      end
    end

    context "disable" do

      example "access to another user edit page" do
        visit edit_user_path(@another_user)
        expect(current_path).to be == root_path
      end

      example "access to another user update action" do
        put user_path(@another_user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "for moderators" do
  end

  context "for admin" do
  end
end
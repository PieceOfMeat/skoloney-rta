require 'spec_helper'

describe 'Authentication' do
  before { @user = FactoryGirl.create :user }

  context "for anonymous users" do

    it "should disable access for user edit page" do
      visit edit_user_path(@user)
      expect(page).to have_selector('h1', :text => 'Sign in')
      expect(page).to have_selector(
        '.alert.alert-error',
        :text => UsersController::SIGNIN_NEEDED_MESSAGE)
    end

    it "should disable requests to the update action" do
      put user_path(@user)
      expect(response).to redirect_to(signin_path)
    end

    it "should disable request to the delete action" do
      delete user_path(@user)
      expect(response).to redirect_to(signin_path)
    end

  end

  context "for signed in users" do
    before do
      sign_in @user
      @another_user = FactoryGirl.create(:user, :email => 'pieceofmeat@yandex.ru', :login => 'skoloney')
    end

    it "should disable access to another user edit page" do
      visit edit_user_path(@another_user)
      expect(current_path).to be == root_path
    end

    it "should disable access to another user update action" do
      put user_path(@another_user)
      expect(response).to redirect_to(root_path)
    end
  end
end
require 'spec_helper'

describe User do

  before { @user = FactoryGirl.build(:user) }

  it "should contain attributes" do
    expect(@user).to respond_to(:address, :birthday, :city, :country, :email, 
                                :full_name, :login, :password, 
                                :password_confirmation, :password_digest,
                                :state, :zip, :authenticate, :remember_token)
  end

  it "should downcase email upon saving" do
    @user.email = "SERGEY.KOLONEY@GMAIL.COM"
    @user.save
    expect(@user.email).not_to match(/[A-Z]/)
  end

  context "validation" do

    it "should pass for valid user" do
      expect(@user).to be_valid
    end

    it "should verify presence of login and email" do
      @user.full_name = " "
      expect(@user).not_to be_valid

      @user.full_name = "Sergey Koloney"
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "should not validate incorrect email addresses" do
      %w[user@foo,com
         user_at_foo.org
         example.user@foo.foo@bar_baz.com
         foo@bar+baz.com].each do |email|

        @user.email = email
        expect(@user).not_to be_valid
      end
    end

    it "should validate correct email addresses" do
      %w[first.last@gmail.jp
         ThE_EmAiL@foo.bar.baz
         quux@bar.baz].each do |email|

        @user.email = email
        expect(@user).to be_valid
      end
    end

    it "should verify uniqueness of email" do
      dup_user = @user.dup
      dup_user.email = dup_user.email.upcase
      dup_user.save
      expect(@user).not_to be_valid
    end

    it "should verify uniqueness of login" do
      dup_user = @user.dup
      dup_user.login = dup_user.login.upcase
      dup_user.save
      expect(@user).not_to be_valid
    end

    it "should verify that password matches confirmation" do
      @user.password_confirmation = "12345"
      expect(@user).not_to be_valid
    end

    it "should verify case when password confirmation is nil" do
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
    end

    context "if user exists" do
      before { @user.save }
      let(:existing_user) { User.find_by_email(@user.email) }

      it "should be valid in absence of password and password_confirm fields" do
        expect(existing_user).to be_valid
      end
    end
  end


  context "authentication" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    it "must pass with correct password" do
      expect(found_user.authenticate("123456")).to be_true
    end

    it "must not pass with incorrect password" do
      expect(found_user.authenticate("12345")).not_to be_true
    end

    it "must create user token upon saving" do
      expect(@user.remember_token).not_to be_empty
    end
  end
end
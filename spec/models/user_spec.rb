require 'spec_helper'

describe User do

  before do
    @user = User.new(
      address: "Sanatornaya 9/2",
      birthday: "1986-09-02",
      city: "Donetsk",
      country: "Ukraine",
      email: "sergey.koloney@gmail.com",
      full_name: "Sergey Koloney",
      login: "pieceofmeat",
      password: "123456",
      password_confirm: "123456",
      state: "Donetsk",
      zip: "83062"
    )
  end

  it "should contain attributes" do
    expect(@user).to respond_to(:address, :birthday, :city, :country, :email, :full_name, :login, :password, :password_confirm, :state, :zip)
  end

  describe "validation" do

    it "should pass validation" do
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
  end

  it "should downcase login and email upon saving" do
    @user.email = "SERGEY.KOLONEY@GMAIL.COM"
    @user.login = "PIECEOFMEAT"
    @user.save

    expect(@user.login).not_to match(/[A-Z]/)
    expect(@user.email).not_to match(/[A-Z]/)
 end

 

end
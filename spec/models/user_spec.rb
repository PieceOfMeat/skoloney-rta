require 'spec_helper'


RSpec.configure do |c|
  c.filter_run_excluding :broken => true
end


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
      password_confirmation: "123456",
      state: "Donetsk",
      zip: "83062"
    )
  end
  subject { @user }

  it "should contain attributes" do
    expect(@user).to respond_to(:address, :birthday, :city, :country, :email, 
                                :full_name, :login, :password, 
                                :password_confirmation, :password_digest,
                                :state, :zip, :authenticate)
  end

  it "should downcase login and email upon saving" do
    @user.email = "SERGEY.KOLONEY@GMAIL.COM"
    @user.login = "PIECEOFMEAT"
    @user.save

    expect(@user.login).not_to match(/[A-Z]/)
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
  end


  context "authentication" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    it "with correct password" do
      expect(found_user.authenticate("123456")).to be_true
    end

    it "with incorrect password" do
      expect(found_user.authenticate("12345")).not_to be_true
    end
  end
end
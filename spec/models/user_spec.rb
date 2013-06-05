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
  subject { @user }


  describe "Model attributes" do
    it { should respond_to(:address, :birthday, :city, :country, :email, :full_name, :login, :password, :password_confirm, :state, :zip) }
  end

  describe "Model validation" do
    it { should be_valid }
  end

  describe "Absence of full name" do
    before { @user.full_name = " " }
    it { should_not be_valid }
  end

  describe "Absence of email" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "Invalid email format" do
    it "should be invalid" do

      incorrect_emails = %w[
        user@foo,com
        user_at_foo.org
        example.user@foo.foo@bar_baz.com
        foo@bar+baz.com
      ]

      incorrect_emails.each do |email|
        @user.email = email
        @user.should_not be_valid
      end
    end
  end

  describe "Valid email format" do
    it "should be valid" do

      correct_emails = %w[
        first.last@gmail.jp
        ThE_EmAiL@foo.bar.baz
        quux@bar.baz
      ]
      
      correct_emails.each do |email|
        @user.email = email
        @user.should be_valid
      end
    end
  end

  describe "Email should be unique" do
    before do
      dup_user = @user.dup
      dup_user.email = dup_user.email.upcase
      dup_user.save
    end

    it { should_not be_valid }
  end

  describe "Login should be unique" do
    before do
      p @user.login
      dup_user = @user.dup
      dup_user.login = dup_user.login.upcase
      dup_user.save
    end

    it { should_not be_valid }
  end

  describe "Login and email gets downcased when storing model" do
    it "should be downcased" do
      @user.email = "SERGEY.KOLONEY@GMAIL.COM"
      @user.login = "PIECEOFMEAT"
      @user.save

      @user.login.should_not =~ /[A-Z]/ && @user.email.should_not =~ /[A-Z]/
    end
    
  end

end
require 'spec_helper'

describe Advertisement do
  
  before do
    @user = FactoryGirl.create(:user)
    @advert = @user.advertisements.build(:content => "Test content")
  end

  it "should respond to attributes" do
    expect(@advert).to respond_to(:content, :user)
    expect(@advert).to have_attached_file(:picture)
  end

  it "should have user attribute" do
    expect(@advert.user).to be == @user
  end

  it "should not allow access to user_id" do
    expect do
      Advertisement.new(:user_id => @user.id)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  context "validation" do
    it "should pass" do
      p @advert.picture
      expect(@advert).to be_valid
    end

    example "when user_id is not set" do
      @advert.user_id = nil
      expect(@advert).not_to be_valid
    end

    example "when content is blank" do
      @advert.content = ''
      expect(@advert).not_to be_valid
    end

    example "for picture file" do
      expect(@advert).to validate_attachment_content_type(:picture)
              .allowing('image/png', 'image/gif', 'image/jpeg')
              .rejecting('text/plain', 'text/xml')

      expect(@advert).to validate_attachment_size(:picture)
              .less_than(500.kilobytes)
    end


  end
end

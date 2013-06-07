class User < ActiveRecord::Base

  attr_accessible :address, :birthday, :city, :country, :email, :full_name,
  :login, :password, :password_confirmation, :state, :zip

  has_secure_password
  acts_as_gmappable :check_process => false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :address, :birthday, :city, :country, :email, :full_name, :login,
  :password, :password_confirmation, :state, :zip, presence: true, length: { maximum: 255 }

  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, :login, uniqueness: { case_sensitive: true }


  before_save do |user|
    user.email = email.downcase
    user.login = login.downcase
  end


  def gmaps4rails_address
    "#{address}, #{zip}, #{city}, #{state}, #{country}" 
  end
end

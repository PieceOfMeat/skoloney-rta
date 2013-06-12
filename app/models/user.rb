class User < ActiveRecord::Base

  USER_LOCATION_VALIDATE_MESSAGE = "Cannot find your location, please verify location fields"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :address, :birthday, :city, :country, :email, :full_name,
  :login, :password, :password_confirmation, :state, :zip

  has_secure_password
  acts_as_gmappable :check_process => false,
                    :msg => USER_LOCATION_VALIDATE_MESSAGE

  validates :address, :birthday, :city, :country, :email, :full_name, :login,
  :state, :zip, presence: true, length: { maximum: 255 }

  validates :password, :password_confirmation, presence: true, :if => :new_record?

  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: true }


  before_save do |user|
    user.email = email.downcase
    user.remember_token = create_remember_token
  end


  def gmaps4rails_address
    "#{address}, #{zip}, #{city}, #{state}, #{country}" 
  end

  def gmaps4rails_title
    "Location of #{full_name}"
  end

  def recover_password
    new_password = ('a'..'z').to_a.shuffle[0,8].join
    if update_attributes(:password => new_password,
                         :password_confirmation => new_password)
    
      UserMailer.password_recovery(self).deliver
    end
  end

  def self.find_by_email_or_login(login)
    login = login.downcase
    User.find_by_email(login) || User.first(:conditions => ["lower(login) = ?", login])
  end

  private
    def create_remember_token
      SecureRandom.urlsafe_base64
    end
end

class User < ActiveRecord::Base
  attr_accessible :address, :birthday, :city, :country, :email, :full_name, :login, :password, :password_confirm, :state, :zip
end

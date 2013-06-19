class Advertisement < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :content, :user_id, :presence => true
end

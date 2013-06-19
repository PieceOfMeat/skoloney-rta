class Advertisement < ActiveRecord::Base
  attr_accessible :content, :picture
  belongs_to :user

  has_attached_file :picture,
                    :styles => { :medium => "150x150>",
                                 :thumb => "50x50>" },
                    :default_url => "/assets/missing.png"

  validates :content, :user_id, :presence => true
  validates_attachment :picture,
    :content_type => { :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'] },
    :size => { :in => 0..500.kilobytes }

end

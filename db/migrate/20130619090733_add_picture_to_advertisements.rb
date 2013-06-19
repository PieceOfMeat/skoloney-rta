class AddPictureToAdvertisements < ActiveRecord::Migration
  def self.up
    add_attachment :advertisements, :picture
  end

  def self.down
    remove_attachment :advertisements, :picture
  end
end

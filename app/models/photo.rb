class Photo < ActiveRecord::Base
attr_accessor :delete_asset
  validates :file, :attachment_presence => true
  has_attached_file :file, styles: { thumb: "300x300#" }, 
                     url: "/system/:hash.:extension",
                     hash_secret: "seamuscoleman"
  before_validation { asset.clear if delete_asset == '1' }
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
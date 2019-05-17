class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private 
  	def picture_size
  		if picture.size > 300.kilobytes
  			errors.add(:picture, "Picture can't be greater than 300 kilobytes")
  		end
  	end
end

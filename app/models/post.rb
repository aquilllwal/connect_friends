class Post < ApplicationRecord
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	mount_uploader :picture, PictureUploader
	validates :user_id, presence: true
	validates :body, length: {minimum: 1, maximum: 250}
	validate  :picture_size

	private

    #restricting the size of a picture to upload
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
class Post < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :body, length: {minimum: 1, maximum: 250}
end
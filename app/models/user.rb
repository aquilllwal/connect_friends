class User < ApplicationRecord
  has_many :posts
	before_save {self.email = email.downcase}
	before_save {self.username = username.downcase}
  validates :username, presence: true, length: {minimum:2, maximum:10},
						format: {with: /^[a-zA-Z ]*$/, multiline: true},
						uniqueness: {case_sensitive: false}

  validates :email, presence: true, length: {maximum: 105},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end
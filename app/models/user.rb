class User < ApplicationRecord
  has_many :posts, dependent: :destroy
	before_save {self.email = email.downcase}
	before_save {self.username = username.downcase}
  validates :username, presence: true, length: {minimum:2},
						# format: {with: /^[a-zA-Z ]*$/, multiline: true},
						uniqueness: {case_sensitive: false}

  validates :email, presence: true, length: {maximum: 105},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def feed
    Post.where("user_id = ?", id)
  end

  def self.new_from_lookup(arg)
    User.find_by(username: arg)
  end

end
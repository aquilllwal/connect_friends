class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, -> { where(friendships: { status: "accepted"}) },
            through: :friendships

  has_many :requested_friends, -> { where(friendships: {status: "requested"}) },
           through: :friendships,
           :source => :friend

  has_many :pending_friends, -> { where(friendships: {status: "pending"}) },
            through: :friendships,
            :source => :friend
  
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

  def self.search(arg)
    User.find_by(username: arg)
  end

end
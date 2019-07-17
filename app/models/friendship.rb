class Friendship < ApplicationRecord
  belongs_to :user
	belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"

	validates_presence_of :user_id, :friend_id

	# to check if users are friend
	def self.exists?(user, friend)
		not find_by_user_id_and_friend_id(user, friend).nil?
	end

	# pending friend request two requests hits db at once one for pending and one requested
	def self.request(user, friend)
		unless user == friend or Friendship.exists?(user, friend)
			transaction do
				create(:user => user, :friend => friend, :status => 'pending')
				create(:user => friend, :friend => user, :status => 'requested')
			end
		end
	end

	# Accept a friend request.
	def self.accept(user, friend)
		transaction do
			accepted_at = Time.now
			accept_one_side(user, friend, accepted_at)
			accept_one_side(friend, user, accepted_at)
		end
	end
end

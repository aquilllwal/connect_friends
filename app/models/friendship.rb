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

	# the below didn't work because find_by is nested with two id:
	# so it threw ActiveRecord::Base error saying needed .id
	# def self.breakup(user, friend)
	# 	transaction do
	# 		byebug
	# 		destroy(find_by_user_id_and_friend_id(user, friend))
	# 		destroy(find_by_user_id_and_friend_id(friend, user))
	# 	end
	# end
	# Delete a friendship or cancel a pending request.
	def self.breakup(user, friend)
		where(user_id:user.id, friend_id:friend.id).destroy_all
		where(user_id:friend.id, friend_id:user.id).destroy_all
	end

	private

	# Update the db with one side of an accepted friendship request.
	def self.accept_one_side(user, friend, accepted_at)
		request = find_by_user_id_and_friend_id(user, friend)
		request.status = 'accepted'
		request.accepted_at = accepted_at
		request.save!
	end

end

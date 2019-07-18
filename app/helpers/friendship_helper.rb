module FriendshipHelper
	# Return an appropriate friendship status message.
	def friendship_status(user, friend)
		friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
		return "#{friend.username} is not your friend (yet)." if friendship.nil?
		case friendship.status
		when 'requested'
			"#{friend.username} would like to be your friend."
		when 'pending'
			"You have requested friendship from #{friend.username}."
		when 'accepted'
			"#{friend.username} is your friend."
		end
	end
end

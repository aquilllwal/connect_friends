class FriendshipController < ApplicationController
before_action :setup_friends

def create
	Friendship.request(@user, @friend)
	flash[:notice] = "Friend request sent."
	redirect_to user_path(@friend)
end

def accept
	if @user.requested_friends.include?(@friend)
		Friendship.accept(@user, @friend)
		flash[:notice] = "Friendship with #{@friend.username} accepted!"
	else
		flash[:notice] = "No friendship request from #{@friend.username}."
	end
	redirect_to users_path
end

def decline
	if @user.requested_friends.include?(@friend)
		Friendship.breakup(@user, @friend)
		flash[:notice] = "Friendship with #{@friend.username} declined"
	else
		flash[:notice] = "No friendship request from #{@friend.username}."
	end
	redirect_to users_path
end

def cancel
	# byebug
	if @user.pending_friends.include?(@friend)
		Friendship.breakup(@user, @friend)
		flash[:notice] = "Friendship request canceled."
	else
		flash[:notice] = "No request for friendship with #{@friend.username}"
	end
	redirect_to users_path
end

def delete
	# byebug
	if @user.friends.include?(@friend)
		Friendship.breakup(@user, @friend)
		flash[:notice] = "Friendship with #{@friend.username} deleted!"
	else
		flash[:notice] = "You aren't friends with #{@friend.username}"
	end
	redirect_to users_path
end

private
	def setup_friends
		@user = User.find(session[:user_id])
		@friend = User.find(params[:id])
	end
end

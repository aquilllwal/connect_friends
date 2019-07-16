class WelcomeController < ApplicationController
	def home
		if logged_in?
			@post = current_user.posts.build
			@feed_items = current_user.posts.paginate(page: params[:page])
		end
	end
end
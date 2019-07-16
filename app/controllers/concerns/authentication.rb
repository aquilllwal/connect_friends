module Authentication
	
	private

		def logged_in_user
			unless logged_in?
				# store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end

		
		def current_user
			if session[:user_id]
				@current_user ||= User.find_by(id: session[:user_id])
			end
		end

		def logged_in?
			!current_user.nil?
		end

		def current_user?(user)
			user == current_user
		end
end
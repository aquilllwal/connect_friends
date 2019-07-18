class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include Authentication
  include SessionsHelper
  include FriendshipHelper
  
  helper_method :current_user?, :logged_in?, :current_user, :friendship_status

end

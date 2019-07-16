class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include Authentication
  include SessionsHelper
  
  helper_method :current_user?, :logged_in?, :current_user

end

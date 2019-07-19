require 'test_helper'
require 'friendship_controller'
class FriendshipControllerTest < ActionDispatch::IntegrationTest

  def setup
    @controller = FriendshipController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @user = User.last
    @friend = User.first
    # Make sure deliveries aren't actually made!
    ActionMailer::Base.delivery_method = :test
  end

end

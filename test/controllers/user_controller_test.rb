require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get signup_path
    assert_response :success
  end

  def setup
    @user = User.first
    @other_user = User.second
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end


end

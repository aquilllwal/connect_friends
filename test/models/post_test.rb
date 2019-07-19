require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = User.first
    # This code is not idiomatically correct.
    @post = Post.new(user: @user, body: "Lorem ipsum")
  end

  test "should be valid" do
    assert_not @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "body should be present" do
   @post.body = "   "
    assert_not@post.valid?
  end

  test "body should be at most 140 characters" do
   @post.body = "a" * 141
    assert_not@post.valid?
  end

  test "order should be most recent first" do
    assert_equal Post.last, Post.first
  end

end
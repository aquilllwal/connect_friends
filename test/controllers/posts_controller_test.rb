require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = Post.first
  end

end

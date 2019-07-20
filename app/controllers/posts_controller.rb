class PostsController < ApplicationController
	before_action :logged_in_user, only:[:create, :destroy, :edit]
  before_action :correct_user,   only: [:destroy, :edit]
  
	def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
		else
			@feed_item = []
      render 'welcome/home'
    end
  end

	def destroy
		@post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
	end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to user_path(@post.user)
    else
      render "edit"
    end
  end


  private

    def post_params
      params.require(:post).permit(:body, :picture)
		end
		
		def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end

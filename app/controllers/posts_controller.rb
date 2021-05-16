class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
  	@posts = Post.all
  end

  def new
    @post = Post.new
  end 

  def create
  	post = Post.create(post_params(params[:post]))
  	post.user = current_user
  	current_user.posts << post
  	redirect_to posts_path
  end

  def show
  	@post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.update(post_params(params[:post]))
      redirect_to post_path(@post)
    else
      flash[:alert] = "You do not have authorization to edit this post"
      render :show
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path
    else
      flash[:alert] = "You do not have authorization to delete this post"
      render :show
    end  
  end 


  private
    def post_params(*args)
      params.require(:post).permit(:title, :content)
    end	
end

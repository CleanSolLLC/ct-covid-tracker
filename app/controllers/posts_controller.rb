class PostsController < ApplicationController
  before_action :find_post, except: [:index, :new, :create]
  #skip_before_action :date_error?

  def index
  	@posts = Post.all
  end

  def new
    @post = Post.new
  end 

  def create
  	  @post = Post.create(post_params(params[:post]))
      @post.user = current_user
    
    if @post.save 
      #current_user.posts << @post
      @post.comments.build
  	  redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @post.user != current_user
      redirect_to post_path(@post)
    end
  end

  def update
    @post.update(post_params(params[:post]))
    redirect_to post_path(@post)
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end  
  end 


  private
    def post_params(*args)
      params.require(:post).permit(:title, :content)
    end

    def find_post
      @post = Post.find(params[:id])      
    end	
end

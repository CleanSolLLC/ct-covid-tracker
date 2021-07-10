class CommentsController < ApplicationController

  #skip_before_action :date_error?
  before_action :find_post, only: [:create, :destroy]  
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comment_params(params[:comment])) 
    @comment.user = current_user

    if @comment.save
  	  @post.comments << @comment
  	  redirect_to post_path(@post)
    else
      render :'posts/show'
    end
  end 

  def edit
    if current_user.id != @comment.user_id
      redirect_to post_path(@comment.post)
    end
  end

  def update
    @comment.update(comment_params(params[:comment]))
    redirect_to post_path(@comment.post)
  end

  def destroy
    if @comment.user_id == current_user.id || @comment.post.user_id == current_user.id
      @comment.destroy
    end
    redirect_to post_path(@post)
  end



  private
    def comment_params(*args)	
      params.require(:comment).permit(:comment)	
    end

    def find_post
      @post = Post.find(params[:post_id])      
    end

    def find_comment
      @comment = Comment.find(params[:id])    
    end
    
end
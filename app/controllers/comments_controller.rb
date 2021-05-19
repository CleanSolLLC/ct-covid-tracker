class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
    #@comment = @post.comments.build(:user_id => current_user.id)
    @comment = @post.comments.create(comment_params(params[:comments])) 
    @comment.user = @post.user

    if @comment.save
  	  @post.comments << @comment
  	  redirect_to post_path(@post)
    else
      render :'posts/show'
    end
  end 


  private
    def comment_params(*args)	
      params.require(:comment).permit(:remarks)	
    end
end
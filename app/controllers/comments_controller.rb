class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
  	comment = Comment.create(comment_params(params[:comment]))
  	comment.user = current_user
  	@post.comments << comment
  	redirect_to post_path(@post)
  end 


  private
    def comment_params(*args)	
      params.require(:comment).permit(:remarks, :current_user)	
    end
end
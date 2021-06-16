class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params(params[:comments])) 
    @comment.user = current_user

    if @comment.save
  	  @post.comments << @comment
  	  redirect_to post_path(@post)
    else
      render :'posts/show'
    end
  end 

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if current_user.id != @comment.user_id
      flash[:alert] = "You are not authorized to edit this comment"
      redirect_to post_path(@post)
    end
  end

  def update
    comment = Comment.find(params[:id])
    @post = comment.post
    @comment = comment.update(comment_params(params[:comment]))
    redirect_to post_path(@post)
  end

  def destroy
    binding.pry
  end



  private
    def comment_params(*args)	
      params.require(:comment).permit(:comment)	
    end
end
class CommentsController < ApplicationController

  before_action :require_user, only: [:create]
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @post.comments << @comment
    @comment.user = current_user


    if @comment.save!
      redirect_to post_path(@post)
    else
      render 'post/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
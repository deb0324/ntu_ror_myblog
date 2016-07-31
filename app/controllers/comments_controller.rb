class CommentsController < ApplicationController

  before_action :require_user, only: [:create, :vote]
  
  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { redirect_to :back } 
      format.js
    end
    
  end

  def create
 
    @post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @post.comments << @comment
    @comment.user = current_user

    if @comment.save
     redirect_to post_path(@post)
    else
      render post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
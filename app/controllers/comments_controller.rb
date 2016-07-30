class CommentsController < ApplicationController

  before_action :require_user, only: [:create, :vote]
  
  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(votable: @comment, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:success] = 'Your vote was counted (๑•̀ㅂ•́)و✧'
    else
      flash[:error] = "You can only vote once (๑•̀ㅂ•́)و✧"
    end

    redirect_to :back
    
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
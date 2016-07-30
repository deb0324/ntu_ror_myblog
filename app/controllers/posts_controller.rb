class PostsController < ApplicationController

  before_action :require_user, only:[:new, :create, :vote]
  before_action :require_permission, only:[:edit, :update, :destroy]

  def vote
    @post = Post.find(params[:id])
    @vote = Vote.create(votable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { redirect_to :back } 
      format.js
    end
  end


  def index
    
    case params[:type]
    when "recent"
      @posts = Post.all.order(:updated_at).reverse
    when "vote"
      @posts = Post.all.sort_by{|x| x.total_votes}.reverse
    when "comment"
      @posts = Post.all.sort_by{|x| x.total_comments}.reverse
    when "tag"
      @posts = Post.all.sort_by{|x| x.total_tags}.reverse 
    else
      @posts = Post.all.reverse
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    #@post = Post.create(post_params)
    @post = Post.create(title: params[:title], content: params[:content])
    @post.user = current_user

    # Category logic
    all_cat = Category.all.pluck(:title)
    user_cat = params[:categories].split(",")

    #trim any white spaces
    user_cat.each do |cat|
      cat.strip!
    end

    # existing categories
    (all_cat & user_cat).each do |cat|
      @post.categories << Category.find_by_title(cat)
    end

    # new categories
    (user_cat - all_cat).each do |cat|
      @post.categories << Category.create(title: cat)
    end
    ##
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    #delete post
    @post = Post.find(params[:id])
    @post.destroy

    #delete all comments associated with post
    @comments = @post.comments
    @comments.each do |comment|
      comment.destroy
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :categories)
  end
end
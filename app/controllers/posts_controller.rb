class PostsController < ApplicationController

  #before_action :require_user, only:[:new, :create, :edit, :update, :destroy]
  before_action :require_user, only:[:new, :create]
  before_action :require_author, only:[:edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    #binding.pry
    post = Post.new(post_params)
    post.user = current_user

    # Category logic
    all_cat = Category.all.pluck(:title)
    user_cat = post_params[:categories].split(",")

    (all_cat & user_cat).each do |cat|
      post.categories << Category.create(title: cat)
    end

    (all_cat - user_cat).each do |cat|
      post.categories << Category.find_by_title(cat)
    end
    ##
    
    if post.save!
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
    #binding.pry
    #delete post
    @post = Post.find(params[:format]) # TODO: why format? how to get id?
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
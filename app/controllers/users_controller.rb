class UsersController < ApplicationController

  def index
    
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create

    @user = User.create(user_params)


    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render :new
      
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password, :nickname)
  end
end
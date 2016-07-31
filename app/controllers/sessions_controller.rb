class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_username(params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Log in successful"
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:error] = "Wrong username or password (｡•ˇ‸ˇ•｡)"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:notice] = "Log out successful"
    redirect_to posts_path
  end


end
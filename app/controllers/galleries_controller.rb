class GalleriesController < ApplicationController

  def index
    @galleries = User.find(params[:format]).galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
    @frame = Frame.new
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.create(gallery_params)
    @gallery.user = current_user

    if @gallery.save
      redirect_to galleries_path(current_user)
    else
      render :new
    end

  end

  private

  def gallery_params
    params.require(:gallery).permit(:title)
  end
end
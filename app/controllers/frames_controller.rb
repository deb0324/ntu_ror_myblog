class FramesController < ApplicationController

  def index
    @frames = Frame.all
  end

  def new
    @frame = Frame.new
  end

  def create

    @gallery = Gallery.find(params[:gallery_id])
    @frame = Frame.create(frame_params)
    @gallery.frames << @frame
  
    if @frame.save
      redirect_to gallery_path(@gallery)
    else
      redirect_to gallery_path(@gallery)
    end
  end


  private

  def frame_params
    params.require(:frame).permit(:name, :image)
  end

end
class FramesController < ApplicationController

  def index
    @frames = Frame.all
  end
end
class GalleriesController < ApplicationController
  def index
    @gallery = Room.all
    @count = 0
  end
end

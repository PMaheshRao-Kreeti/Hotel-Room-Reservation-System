class GalleriesController < ApplicationController
  def index
    @gallery = Room.all
  end
end

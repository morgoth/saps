class GalleriesController < ApplicationController
  def index
    @albums = Picasa.albums
  end

  def show
    @album = Picasa.photos(:album_id => params[:id])
  end
end

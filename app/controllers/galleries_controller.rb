class GalleriesController < ApplicationController

  def albums
      @albums=Picasa.albums
  end

  def photos
      @album=Picasa.photos(params[:id])
  end

end

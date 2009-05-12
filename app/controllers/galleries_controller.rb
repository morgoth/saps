class GalleriesController < ApplicationController

  def albums
      @albums=Picasa.albums 'saps.gliwice'
  end

  def photos
      @album=Picasa.photos( 'saps.gliwice', params[:id])
  end

end

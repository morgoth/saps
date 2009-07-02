class GalleriesController < ApplicationController

  def albums
    @albums = Picasa.albums( :google_user => "saps.gliwice" )
  end

  def photos
    @album = Picasa.photos( :google_user => 'saps.gliwice', :album_id => params[:id])
  end

end

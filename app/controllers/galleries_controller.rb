class GalleriesController < ApplicationController

  def index
    @albums = Picasa.albums( :google_user => "saps.gliwice" )
  end

  def show
    @album = Picasa.photos( :google_user => 'saps.gliwice', :album_id => params[:id])
  end
end

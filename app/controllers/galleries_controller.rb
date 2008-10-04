class GalleriesController < ApplicationController

  def albums
      @albums=Picasa.albums
  end

  def photos
      @photos=Picasa.photos(params[:id])
  end
  
  def slideshow
      redirect_to params[:link]
  end
  
  def test
  end
end

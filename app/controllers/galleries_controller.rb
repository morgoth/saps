class GalleriesController < ApplicationController
  		#include Picasa
	def albums
				@albums=Picasa.albums
  end

  def photos
			@photos=Picasa.photos(params[:id])
  end

end

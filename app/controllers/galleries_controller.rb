class GalleriesController < ApplicationController
  def index
    @albums = picasa.album.list.entries
  end

  def show
    @album = picasa.album.show(params[:id])
  end

  private

  def picasa
    @picasa ||= Picasa::Client.new(user_id: "saps.gliwice")
  end
end

require 'net/http'
require "xmlsimple"
require 'picasa/web_albums'

module Picasa
  def self.albums(options = {})
    raise ArgumentError.new("You must specify google_user") unless options[:google_user]
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.albums
  end

  def self.photos(options = {})
    raise ArgumentError.new("You must specify google_user") unless options[:google_user]
    raise ArgumentError.new("You must specify album_id") unless options[:album_id]
    web_albums = Picasa::WebAlbums.new(options[:google_user])
    web_albums.photos(options[:album_id])
  end
end

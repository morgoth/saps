module Picasa
require 'net/http'
require "xmlsimple"
GOOGLE_USER = 'saps.gliwice'

  def  albums
    #returns [ {:id => "id", :title => "title"}, {another one} ]
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get("/data/feed/api/user/#{GOOGLE_USER}")
    xml=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
    albums = []
    xml['entry'].each do |album|
			attribute ={}
      attribute[:id] = album['id'][1]
      attribute[:title] = album['title']
			albums << attribute
    end
      albums
  end

  def photos(album_id)
    #returns {:photos => [:title, :thumbnail, :photo], :slideshow => "link to picasa slideshow"}
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get("/data/feed/api/user/#{GOOGLE_USER}/albumid/#{album_id}")
    xml=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
    photos = []
    xml['entry'].each do |photo|
			attribute = {}
      attribute[:title] = photo['group'][0]['description'][0]['content'] #returns nil if empty
      attribute[:thumbnail] = photo['group'][0]['thumbnail'][1]['url']
      #attributes[:photo] << photo['group'][0]['content']['url']
      attribute[:photo] = photo['content']['src']
      #attributes[:photo] << photo['group'][0]['content']['url'].gsub(/http:\/\/lh[0-9]/,'http://lh3')
			photos << attribute
    end
    { :photos => photos, :slideshow => xml['link'][2]['href'] }
  end
  
  module_function :albums, :photos
end 
module Picasa
require 'net/http'
require "xmlsimple"

GOOGLE_USER = 'w.wnetrzak'

  def  albums
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get("/data/feed/api/user/#{GOOGLE_USER}")
    xml=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
    attributes={ :title =>[], :id => [] }
		xml['entry'].each do |album|
				attributes[:id] << album['id'][1]
				attributes[:title] << album['name'][0]
		end
			attributes
  end

  def photos(album_id)
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get("/data/feed/api/user/#{GOOGLE_USER}/albumid/#{album_id}")
    xml=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
		attributes={ :title =>[], :thumbnail => [], :photo=>[] }
		 xml['entry'].each do |photo|
			attributes[:title] << photo['group'][0]['title'][0]['content']
			attributes[:thumbnail] << photo['group'][0]['thumbnail'][1]['url']
			attributes[:photo] << photo['group'][0]['content']['url']
		end
			attributes
  end
	
	module_function :albums, :photos
end 
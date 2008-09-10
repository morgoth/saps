module Picasa
require 'net/http'
require "xmlsimple"
GOOGLE_USER = 'saps.gliwice'

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
    attributes={ :title =>[], :thumbnail => [], :photo=>[],:slideshow=>[] }
     xml['entry'].each do |photo|
      attributes[:title] << photo['group'][0]['description'][0]['content'] #returns nil if empty
      attributes[:thumbnail] << photo['group'][0]['thumbnail'][1]['url']
      attributes[:photo] << photo['group'][0]['content']['url']
      #attributes[:photo] << photo['group'][0]['content']['url'].gsub(/http:\/\/lh[0-9]/,'http://lh3')
    end
    attributes[:slideshow] << xml['link'][2]['href']
      attributes
  end
  
  module_function :albums, :photos
end 
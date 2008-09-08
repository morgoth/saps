class Picasa
require 'net/http'
#require "rexml/document";
require "xmlsimple"
attr_accessor :xml, :album_id, :xml_album

  def  initialize
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get('/data/feed/api/user/w.wnetrzak')
    @xml=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
    @album_id=xml['entry'][0]['id'][1]
  end

  def photos
    http=Net::HTTP.new('picasaweb.google.com')
    resp, data = http.get("/data/feed/api/user/w.wnetrzak/albumid/#{@album_id}")
    @xml_album=XmlSimple.xml_in(data, 'KeyAttr' => 'name')
    #a.xml_album['entry'][0]['group'][0]['thumbnail'][0]['url']
  end
end 
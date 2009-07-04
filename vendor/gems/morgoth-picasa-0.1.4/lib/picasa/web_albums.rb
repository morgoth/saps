module Picasa
  class WebAlbums
    attr_accessor :google_user

    def initialize(google_user)
      @google_user = google_user
    end

    def albums
      data = connect("/data/feed/api/user/#{google_user}")
      xml=XmlSimple.xml_in(data)
      albums = []
      xml['entry'].each do |album|
        attributes = {}
        attributes[:id] = album['id'][1]
        attributes[:title] = album['title'][0]['content']
        attributes[:photos_count] = album['numphotos'][0].to_i
        albums << attributes
      end
      albums
    end

    def photos(album_id)
      data = connect("/data/feed/api/user/#{google_user}/albumid/#{album_id}")
      xml = XmlSimple.xml_in(data)
      photos = []
      xml['entry'].each do |photo|
        attributes = {}
        attributes[:title] = photo['group'][0]['description'][0]['content'] #returns nil if empty
        attributes[:thumbnail_1] = photo['group'][0]['thumbnail'][0]['url']
        attributes[:thumbnail_2] = photo['group'][0]['thumbnail'][1]['url']
        attributes[:thumbnail_3] = photo['group'][0]['thumbnail'][2]['url']
        #attributes[:photo] << photo['group'][0]['content']['url']
        attributes[:photo] = photo['content']['src']
        photos << attributes
      end
      { :photos => photos, :slideshow => xml['link'][2]['href'] }
    end

    private

    def connect(url)
      full_url = "http://picasaweb.google.com" + url
      Net::HTTP.get(URI.parse(full_url))
    end
  end
end
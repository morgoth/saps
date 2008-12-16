xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "New scores"

    for match in @matches
      xml.item do
        xml.pubDate match.updated_at.to_s( :rfc822 )
				xml.description do
					xml << h(render(:partial => match ))
				end
      end
    end
  end
end

xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
	xml.channel do
		xml.title "USAi.net News"
		xml.link url_for	:only_path => false,
							:controller => 'news_items',
							:action => 'index'
		xml.pubDate @news_items.first.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z")
		xml.description h("The latest news concerning USAi.net.")
		@news_items.each do |news_item|
			if news_item.published
				xml.item do
					xml.title news_item.title
					xml.link url_for 	:only_path => false,
										:controller => 'news_items',
										:action => 'show',
										:id => news_item.id
					xml.description h(news_item.description.to_s)
					xml.pubDate news_item.updated_at.strftime("%a, %d %b %Y %H:%M:%S %z")
					xml.guid url_for 	:only_path => false,
										:controller => 'news_items',
										:action => 'show',
										:id => news_item.id
					xml.author "USAi.net"
				end
			end
		end
	end
end
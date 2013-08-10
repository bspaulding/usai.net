class NewsItem < ActiveRecord::Base
	validates_presence_of :title, :article
end

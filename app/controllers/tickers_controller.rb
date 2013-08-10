class TickersController < ApplicationController

	def news
		@news_items = NewsItem.all(:order => "updated_at DESC")
		#headers['content-type'] = 'text/javascript'
		render :layout => false
	end

	def testimonials
		@testimonials = Testimonial.all.shuffle
		headers['content-type'] = 'text/javascript'
		render :layout => false
	end
end

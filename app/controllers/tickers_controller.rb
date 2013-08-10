class TickersController < ApplicationController

	def news
		@news_items = NewsItem.find(:all, :order => "updated_at DESC")
		#headers['content-type'] = 'text/javascript'
		render :layout => false
	end

	def testimonials
		@testimonials = Testimonial.find(:all).shuffle
		headers['content-type'] = 'text/javascript'
		render :layout => false
	end
end

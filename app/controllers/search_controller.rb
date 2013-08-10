class SearchController < ApplicationController

	def index
		if params[:query]
			@query = params[:query]
			@results = Page.find_by_contents @query
		else
			flash[:notice] = "Please enter a word or phrase in the search field."
			redirect_to :controller => 'sections', :action => 'index'
		end
	end
end

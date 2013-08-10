class NewsItemsController < ApplicationController
	before_filter :check_authentication, :except => ['index', 'show']
	uses_tiny_mce(	:options => {
						:theme => 'advanced',
						:mode => 'exact',
						:elements => 'news_item[article]',
						:browsers => %w{msie gecko safari},
						:theme_advanced_toolbar_location => "top",
						:theme_advanced_toolbar_align => "left",
						:theme_advanced_resizing => true,
						:theme_advanced_resize_horizontal => false,
						:paste_auto_cleanup_on_paste => false,
						:theme_advanced_buttons1 => %w{undo redo separator bold italic underline separator justifyleft justifycenter justifyright separator bullist numlist separator code},
						:theme_advanced_buttons2 => [],
						:theme_advanced_buttons3 => [],
						:plugins => %w{contextmenu paste},
						:extended_valid_elements => "form[*],input[*],option[*],select[*],script[*],object[*],embed[*]"},
					:only => [:new, :edit])
	
	def index
		@news_items = NewsItem.find(:all, :conditions => ["published = ?", 1], :order => "created_at DESC", :limit => 10)
		if params[:format] == 'rss'
			render :layout => false
		end
	end
	
	def show
		begin
			@news_item = NewsItem.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No news item with id '<em>#{params[:id]}</em>'."
			redirect_to :action => 'index'
		end
		if !@news_item.published
			if session[:user]
				flash[:notice] = "This article is unpublished."
			else
				redirect_to :action => 'index'
			end
		end	
	end
	
	def new
		@news_item = NewsItem.new
	end
	
	def create
		@news_item = NewsItem.new(params[:news_item])
		if @news_item.save
			flash[:notice] = "Sucessfully Created News Item."
			redirect_to @news_item
		else
			flash[:notice] = "Creation Unsuccessful."
			redirect_to :action => 'new'
		end
	end
	
	def edit
		begin
			@news_item = NewsItem.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to :action => 'new'
		end
	end
	
	def update
		@news_item = NewsItem.find(params[:id])
		if @news_item.update_attributes(params[:news_item])
			flash[:notice] = "Successfully Updated News Item."
		else
			flash[:notice] = "Could not update news item."
		end
		redirect_to @news_item
	end
	
	def destroy
		begin
			NewsItem.destroy(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No article with id '#{params[:id]}' found."
			redirect_to :action => 'index'
		end
		flash[:notice] = "Article with id '#{params[:id]}' has been destroyed."
		redirect_to :controller => 'admin', :action => 'manage_news_items'
	end
end

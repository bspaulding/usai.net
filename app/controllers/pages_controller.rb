class PagesController < ApplicationController
	before_filter :check_authentication, :except => [:index, :show]
	uses_tiny_mce(	:options => {
						:theme => 'advanced',
						:mode => 'exact',
						:elements => 'page[body]',
						:browsers => %w{msie gecko safari},
						:theme_advanced_toolbar_location => "top",
						:theme_advanced_toolbar_align => "left",
						:theme_advanced_resizing => true,
						:theme_advanced_resize_horizontal => false,
						:paste_auto_cleanup_on_paste => false,
						:theme_advanced_buttons1 => %w{undo redo separator bold italic underline separator justifyleft justifycenter justifyright separator bullist numlist separator link unlink separator code},
						:theme_advanced_buttons2 => [],
						:theme_advanced_buttons3 => [],
						:plugins => %w{contextmenu paste},
						:valid_elements => "*[*]",
						:extended_valid_elements => "form[*],input[*],option[*],select[*],script[*],embed[*],object[*]",
						:invalid_elements => "",
						:cleanup => false},
					:only => [:new, :edit])
	
	def index
		if params[:category_id]
			@pages = Page.find(:all, :conditions => ['category_id = ?', params[:category_id]])
		else
			@pages = Page.find(:all)
		end
	end

	def show
		begin
		  if params[:page_name]
  		  @page = Page.find_by_name(params[:page_name].humanize)	
  		else
  			@page = Page.find(params[:id])
  		end
  		
			if !@page.published
				if session[:user]
					flash[:notice] = "This page is unpublished."
				else
					redirect_to @page.category
				end
			end
			@categories = @page.category.section.categories
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No page with id '<em>#{params[:id]}</em>'."
			redirect_to 'index'
		end
	end

	def new
		@sections = Section.find(:all)
		@categories = Category.find(:all)
		@page = session[:page_draft] || Page.new
	end

	def create
		@page = Page.new(params[:page])
		if @page.save!
			flash[:notice] = "Successfully Created Page!"
			session[:page_draft] = nil
			redirect_to @page
		else
			render :action => 'new'
		end
	end
	
	def edit
		@sections = Section.find(:all)
		@categories = Category.find(:all)
		begin
			@page = Page.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			logger.error "Attempt to access invalid page #{params[:id]}"
			flash[:notice] = "Invalid Page"
			redirect_to :action => :index
		end
	end
	
	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			flash[:notice] = "Successfully Updated Page."
			redirect_to @page
		else 
			render :action => 'edit'
		end
	end
	
	def sort
		@pages = Category.find(params[:id]).pages
		@pages.each_with_index do |page, index|
			page.position = params["pages_list"].index(index.to_s) + 1
			page.save
		end
		render :update do |page|
			page.replace_html "pages_list", :partial => 'admin/list_pages_in_category', :object => Category.find(params[:id])
			page.visual_effect :highlight, "pages_list"
		end
	end
	
	def save_draft
		session[:page_draft] = Page.new(params[:page])
	end
	
	def destroy
		begin
			Page.destroy(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No page with id '#{params[:id]}' found."
			redirect_to :action => 'index'
		end
		flash[:notice] = "Page with id '#{params[:id]}' has been destroyed."
		redirect_to :controller => 'admin', :action => 'manage_pages'
	end
end

class CategoriesController < ApplicationController
	before_filter :check_authentication, :except => ['index', 'show']
	uses_tiny_mce(	:options => {
						:theme => 'advanced',
						:mode => 'exact',
						:elements => 'category[body]',
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
						:extended_valid_elements => "form[*],input[*],option[*],select[*],script[*],embed[*],object[*]",
						:cleanup => false},
					:only => [:new, :edit])
	
	def index
		if params[:section_id]
			category = Category.find(:first, :conditions => ['section_id = ?', params[:section_id]])
		else
			category = Category.find(:first)
		end
		redirect_to category.pages.first
	end

	def show
		begin
		  if params[:section_name] && params[:category_name]
		    section = Section.find_by_name(params[:section_name].humanize)
 		    @category = section.categories.find_by_name(params[:category_name].humanize)
		  else
  			@category = Category.find(params[:id])
  		end
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No category with id '<em>#{params[:id]}</em>'."
			redirect_to :action => 'index'
		end
		#if @category.pages.size > 0
		#	redirect_to @category.pages.first
		#end
	end

	def new
		@sections = Section.find(:all)
		@category = session[:category_draft] || Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category.save!
			flash[:notice] = "Successfully Created Category!"
			redirect_to @category
		else
			render :action => 'new'
		end
	end

	def edit
		@sections = Section.find(:all)
		begin
			@category = Category.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			logger.error "Attempt to access invalid category #{params[:id]}"
			flash[:notice] = "Invalid Category"
			redirect_to :action => :index
		end
	end
	
	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			flash[:notice] = "Successfully Updated Category."
			redirect_to @category
		else 
			render :action => 'edit'
		end
	end
	
	def sort
		@section = Section.find(params[:id])
		for category in @section.categories
			category.position = params["section_#{@section.id}_category_list"].index(category.id.to_s) + 1
			category.save
		end
		render :update do |page|
			page.visual_effect :highlight, "section_#{@section.id}_category_list"
		end
	end
	
	def save_draft
		session[:category_draft] = Category.new(params[:category])
	end
	
	def destroy
		# Category.delete(params[:id])
		flash[:notice] = "At this time you are not allowed to delete categories, only change their names."
		redirect_to :action => 'index'
	end

end
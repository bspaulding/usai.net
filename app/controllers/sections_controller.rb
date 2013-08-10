class SectionsController < ApplicationController
	before_filter :check_authentication, :except => ['index', 'show']

	in_place_edit_for :section, :name

	uses_tiny_mce(	:options => {
						:theme => 'advanced',
						:mode => 'exact',
						:elements => 'section[body]',
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
		flash[:tickers] = true
		@sections = Section.all
		@serviceCategories = @sections.first.categories[0..3]
	end

	def show
		begin
		  if params[:section_name]
		    @section = Section.find_by_name(params[:section_name].humanize)
		  else
  			@section = Section.find(params[:id])
  		end
			@categories = @section.categories
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No section with id '<em>#{params[:id]}</em>'."
			redirect_to :action => 'index'
		end

		#if @section.categories.size > 0
		#	redirect_to @section.categories.first
		#end
	end

	def new
	end

	def create
		@section = Section.new(params[:section])
		if @section.save!
			flash[:notice] = "Successfully Created Section."
			redirect_to @section
		else
			render :action => 'new'
		end
	end

	def edit
		begin
			@section = Section.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			logger.error "Attempt to access invalid section #{params[:id]}"
			flash[:notice] = "Invalid Section"
			redirect_to :action => :index
		end
		#@auth_token = authenticity_token()
	end

	def update
		@section = Section.find(params[:id])
		if @section.update_attributes(params[:section])
			flash[:notice] = "Successfully Updated Section."
			redirect_to :controller => 'admin'
		else
			render :action => 'edit'
		end
	end

	def sort
		@sections = Section.all
		for section in @sections
			section.position = params['sections_list'].index(section.id.to_s) + 1
			section.save
		end
	end

	def destroy
		# Section.delete(params[:id])
		flash[:notice] = "You are not allowed to remove Sections, only to change their names."
		redirect_to :action => 'index'
	end

end

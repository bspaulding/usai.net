class TestimonialsController < ApplicationController
	before_filter :check_authentication, :except => [:partners, :clients]
	
	upload_status_for :new
	
	def partners
	 @testimonials = Testimonial.partners
	end
	
	def clients
	 @testimonials = Testimonial.clients
	end
	
	def index
		@testimonials = Testimonial.find(:all, :order => "updated_at DESC")
	end
	
	def show
		begin
			@testimonial = Testimonial.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No testimonial with id '<em>#{params[:id]}</em>'."
			redirect_to :controller => 'admin', :action => 'index'
		end
	end
	
	def new
		@testimonial = Testimonial.new
	end
	
	def create
		@testimonial = Testimonial.new(params[:testimonial])
		if @testimonial.save
			flash[:notice] = "Sucessfully Created Testimonial."
			redirect_to @testimonial
		else
			flash[:notice] = "Creation Unsuccessful."
			redirect_to :action => 'new'
		end
	end
	
	def upload
		@message = 'File uploaded: ' + params[:testimonial][:image].size.to_s
      	finish_upload_status "'#{@message}'"
	end
	
	def edit
		begin
			@testimonial = Testimonial.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "No testimonial with id '<em>#{params[:id]}</em>'"
			redirect_to :action => 'new'
		end
	end
	
	def update
		@testimonial = Testimonial.find(params[:id])
		if @testimonial.update_attributes(params[:testimonial])
			flash[:notice] = "Successfully Updated Testimonial."
		else
			flash[:notice] = "Could not update testimonial."
		end
		redirect_to @testimonial
	end
	
	def sort
	end
	
	def destroy
	end
end

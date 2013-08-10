class AdminController < ApplicationController
	before_filter :check_authentication, :except => :login
	
	in_place_edit_for :section, :name
	
	def index
		@sections = Section.find(:all)
	end
	
	def login
		if request.post?
			begin
				session[:user] = User.authenticate(params[:username], params[:password]).id
				session[:username] = User.find(session[:user]).username
				session[:last_action_time] = Time.now
				params = session[:intended_params]
				redirect_to :controller => params[:controller],
						:action => params[:action],
						:id => params[:id]
			rescue
				flash[:notice] = "Invalid Username or Password."
			end
		end
	end

	def logout
		session[:user] = nil
		session[:username] = nil
		session[:last_action_time] = nil
		redirect_to :controller => 'sections', :action => 'index'
	end
	
	def manage_sections
		@sections = Section.find(:all, :order => :position)
	end
	
	def manage_categories
		@sections = Section.find(:all, :order => :position)
	end
	
	def manage_pages
		@category = Section.find(:first).categories.first
	end
	
	def get_pages_in_category
		category = Category.find(params[:id])
		render :update do |page|
			page.replace_html "pages_list", :partial => 'list_pages_in_category', :object => category
			page.visual_effect :highlight, "pages_list"
		end
	end
	
	def manage_testimonials
		@testimonials = Testimonial.find(:all)
	end
	
	def gen_link
		@pages = Category.find(:first).pages
	end
	
	def gen_pages_in_category
		category = Category.find(params[:id])
		render :update do |page|
			first_page = category.pages.first
			page.replace_html "generated_link", h("<a href=\"#{url_for first_page}\">#{first_page.name}</a>")
			page.replace_html "pages", :partial => 'option_list_pages_in_category', :object => category
			page.visual_effect :highlight, "pages"
		end
	end
	
	def gen_link_for_page
		link_to_page = Page.find(params[:id])
		render :update do |page|
			page.replace_html "generated_link", h("<a href=\"#{url_for link_to_page}\">#{link_to_page.name}</a>")
			#page.replace_html "generated_link", "test"
			page.visual_effect :highlight, "generated_link"
		end
	end
	
	def view_images
		require 'rubygems'
		require 'alib'
		
		img_dir = "public/images"
		img_types = ["jpg", "jpeg", "png", "gif"]
		
		@images = Array.new
		alib.util.find(img_dir, :follow => true) do |path|
			if FileTest.file? path
				img_types.each do |img_type|
					if path[-4...path.size].include? ".#{img_type}"
						@images.push([path.split("/")[-1], path[6...path.size]])
						break
					end
				end
			end
		end
		@images.sort! do |a, b|
			a[0].downcase <=> b[0].downcase
		end
	end
	
	def upload_image
		f = File.new("public/images/#{params[:image].original_filename}", "wb")
		f.write params[:image].read
		f.close
		redirect_to :action => 'view_images'
	end
	
	def manage_news_items
		@news_items = NewsItem.find(:all)
	end
end

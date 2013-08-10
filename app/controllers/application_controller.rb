# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	helper :all # include all helpers, all the time

	# See ActionController::RequestForgeryProtection for details
	# Uncomment the :secret if you're not using the cookie session store
	protect_from_forgery # :secret => 'ce2577202066eecf15afd319a04786ae'

	layout 'default'
	
	#@session_inactivity_time = 1 # time to logout if inactive for n minutes.
	
	def check_authentication
		unless session[:user]
			# User has never logged in.
			flash[:notice] = "You must login as an administrator to reach that function."
			session[:intended_params] = params
			redirect_to :controller => 'admin', :action => 'login'
			return false
		else
			# User has logged in.Now check to see if user has been active
			active = (Time.now - session[:last_action_time])/60 < 30
			if !active
				session[:user] = nil
				session[:username] = nil
				session[:last_action_time] = nil
				flash[:notice] = "You have been logged out because you were inactive for 30 minutes.<br/>Please log in again."
				session[:intended_params] = params
				redirect_to :controller => 'admin', :action => 'login'
				return false
			else
				session[:last_action_time] = Time.now
			end
		end
	end
	
	ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
		:default => "%m/%d/%Y",
		:date_time12 => "%m/%d/%Y %I:%M%p",
		:date_time24 => "%m/%d/%Y %H:%M",
		:date_named_month => "%B %d, %Y"
	)
end

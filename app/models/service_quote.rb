class ServiceQuote < ActiveRecord::Base
	validates_presence_of :contactName, :emailAddress, :phoneNumber, :interestedIn, :sort_order
	validates_format_of :emailAddress, :with => /\A.*@.*\..*\Z/
end

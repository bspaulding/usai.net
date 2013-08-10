class Section < ActiveRecord::Base
	has_many :categories, :order => :position
	#acts_as_list :scope => :section
	
	validates_presence_of :name
end

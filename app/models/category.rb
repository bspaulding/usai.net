class Category < ActiveRecord::Base
	belongs_to :section
	acts_as_list :scope => :section
	has_many :pages, :order => :position, :dependent => :destroy
	
	validates_presence_of :name, :section_id
end

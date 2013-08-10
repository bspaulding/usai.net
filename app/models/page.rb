class Page < ActiveRecord::Base
	belongs_to :category
	
	acts_as_list :scope => :category
	acts_as_ferret :fields => [:name, :body, :category_name, :category_description, :category_body, :section_name]
	
	validates_presence_of :name, :body, :category_id
	
	def category_name
		return self.category.name
	end
	
	def category_description
		return self.category.description
	end
	
	def category_body
		return self.category.body
	end
	
	def section_name
		return self.category.section.name
	end
end

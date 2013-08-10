class AddSortOrderings < ActiveRecord::Migration
  def self.up
  	add_column :sections, :position, :integer
  	sections = Section.find(:all)
  	sections.each_with_index do |section, index|
  		section.position = index
  		section.save!
  	end
  	
  	add_column :categories, :position, :integer
	categories = Category.find(:all)
	categories.each_with_index do |category, index|
  		category.position = index
  		category.save!
  	end
	
  	add_column :pages, :position, :integer
  	pages = Page.find(:all)
  	pages.each_with_index do |page, index|
  		page.position = index
  		page.save!
  	end
  	
  	add_column :testimonials, :position, :integer
  	testimonials = Testimonial.find(:all)
  	testimonials.each_with_index do |testimonial, index|
  		testimonial.position = index
  		testimonial.save!
  	end
  end

  def self.down
  	remove_column :sections, :position
  	remove_column :categories, :position
  	remove_column :pages, :position
  	remove_column :testimonials, :position
  end
end

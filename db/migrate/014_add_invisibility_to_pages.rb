class AddInvisibilityToPages < ActiveRecord::Migration
  def self.up
  	add_column :pages, :visible, :boolean
  	pages = Page.find(:all)
  	pages.each do |page|
  		page.visible = true
  		page.save
  	end
  end

  def self.down
  	remove_column :pages, :visible
  end
end

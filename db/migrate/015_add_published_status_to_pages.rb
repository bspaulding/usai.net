class AddPublishedStatusToPages < ActiveRecord::Migration
  def self.up
  	add_column :pages, :published, :boolean
  	Page.all.each {|page| page.update_attribute("published", true) }
  end

  def self.down
  	remove_column :pages, :published
  end
end

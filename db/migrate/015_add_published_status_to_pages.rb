class AddPublishedStatusToPages < ActiveRecord::Migration
  def self.up
  	add_column :pages, :published, :boolean
  	Page.update_all("published = true")
  end

  def self.down
  	remove_column :pages, :published
  end
end

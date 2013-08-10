class AddDescriptionToNewsItem < ActiveRecord::Migration
  def self.up
  	add_column :news_items, :description, :text
  end

  def self.down
  	add_column :news_items, :description
  end
end

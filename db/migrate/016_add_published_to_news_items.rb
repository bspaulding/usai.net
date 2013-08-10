class AddPublishedToNewsItems < ActiveRecord::Migration
  def self.up
  	add_column :news_items, :published, :boolean
  	NewsItem.all.each {|news_item| news_item.update_attribute("published", true) }
  end

  def self.down
  	remove_column :news_items, :published
  end
end

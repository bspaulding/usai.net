class AddPublishedToNewsItems < ActiveRecord::Migration
  def self.up
  	add_column :news_items, :published, :boolean
  	NewsItem.update_all("published = true")
  end

  def self.down
  	remove_column :news_items, :published
  end
end

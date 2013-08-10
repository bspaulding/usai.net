class AddCategoryDescriptions < ActiveRecord::Migration
  def self.up
	add_column :categories, :description, :text
  end

  def self.down
	add_column :categories, :description
  end
end

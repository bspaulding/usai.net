class AddBodyToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :body, :text
  end

  def self.down
    remove_column :sections, :body
  end
end

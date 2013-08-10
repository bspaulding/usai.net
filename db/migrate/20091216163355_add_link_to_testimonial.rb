class AddLinkToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :link, :string
  end

  def self.down
    remove_column :testimonials, :link
  end
end

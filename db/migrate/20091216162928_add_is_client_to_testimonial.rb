class AddIsClientToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :is_client, :boolean
  end

  def self.down
    remove_column :testimonials, :is_client
  end
end

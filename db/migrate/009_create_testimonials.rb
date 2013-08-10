class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
	  t.string :imageURL
	  t.text :quote
	  t.string :author
      t.timestamps
    end
  end

  def self.down
    drop_table :testimonials
  end
end

class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
	  t.integer :category_id
	  t.string :name
	  t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end

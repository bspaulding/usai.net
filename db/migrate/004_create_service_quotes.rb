class CreateServiceQuotes < ActiveRecord::Migration
  def self.up
    create_table :service_quotes do |t|
	  t.string :contactName
	  t.string :emailAddress
	  t.integer :phoneNumber
	  t.string :interestedIn
      t.timestamps
    end
  end

  def self.down
    drop_table :service_quotes
  end
end

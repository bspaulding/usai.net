# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

['Services', 'Support Center', 'Coverage', 'Contact Info', 'About Us'].each do |section_name|
  Section.create!(:name => section_name)
end

    # t.integer  "section_id"
    # t.string   "name"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.text     "description"
    # t.integer  "position"
    # t.text     "body"

[
  { :section_name => "Services", :name => "Connectivity",            :position => 1, :description => "Choose our Wired, Wireless or our exclusive \"Dual Connect\" circuit for mission critical Internet connectivity for your business." },
  { :section_name => "Services", :name => "Colocation",              :position => 2, :description => "Install your primary or backup file servers in our secure well connected locations or even rent SAN space" },
  { :section_name => "Services", :name => "Continuity for Business", :position => 3, :description => "Plan! Be ready! Affordable office space equipped with desks, phones, computers, and a data back up. Emergency office space in just hours!" },
  { :section_name => "Services", :name => "Communicate",             :position => 4, :description => "Web Site Design, Hosting and DNS services including Domain Name Registration" }
].each do |category|
  section_name = category.delete(:section_name)
  section = Section.find_by_name(section_name)
  Category.find_or_create_by_name(category.merge({ :section_id => section.id }))
end

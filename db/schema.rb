# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091216163355) do

  create_table "categories", :force => true do |t|
    t.integer  "section_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "position"
    t.text     "body"
  end

  create_table "news_items", :force => true do |t|
    t.string   "title"
    t.text     "article"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "published"
  end

  create_table "pages", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "visible"
    t.boolean  "published"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "body"
  end

  create_table "service_quotes", :force => true do |t|
    t.string   "contactName"
    t.string   "emailAddress"
    t.integer  "phoneNumber"
    t.string   "interestedIn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonials", :force => true do |t|
    t.string   "imageURL"
    t.text     "quote"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "is_client"
    t.string   "link"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

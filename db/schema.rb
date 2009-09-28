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

ActiveRecord::Schema.define(:version => 20090928220638) do

  create_table "card_pages", :force => true do |t|
    t.string   "item_list_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_list_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "item_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "private_notes"
    t.string   "main_image"
    t.string   "card_image"
    t.string   "body_slot"
    t.string   "bonus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

class ItemList < ActiveRecord::Base
  has_many :item_list_items
  has_many :card_pages
  has_many :items, :through => :item_list_items
end

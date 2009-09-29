class ItemListController < ApplicationController

  active_scaffold :item_lists do |config|
    config.columns = [:name, :item_list_items, :card_pages]
    config.update.columns.exclude :card_pages
    config.action_links.add :delete_and_regenerate_card_pages, :type => :record
  end

  def delete_and_regenerate_card_pages
    @list = ItemList.find params[:id]
    @list.regenerate_card_pages
    params[:associations] = 'card_pages'
    nested
  end
  
  def generate_card_pages_recently_modified
    ItemList.find (params[:id]).regenerate_card_pages_since(5.days.ago)
    params[:associations] = 'card_pages'
    nested  
  end
# Need a cleaner way to handle card pages.
# Want to be able to chop & change more easily.
# Card page many-to-many with item?
# This is good enough for my needs just now...
end
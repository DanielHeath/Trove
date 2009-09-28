class ItemListController < ApplicationController

  active_scaffold :item_lists do |config|
    config.columns = [:name, :item_list_items, :card_pages]
    config.update.columns.exclude :item_list_items, :card_pages
  end

end

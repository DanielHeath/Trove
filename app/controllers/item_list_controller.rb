class ItemListController < ApplicationController

  active_scaffold :item_lists do |config|
    config.columns = [:name, :item_list_items, :card_pages]
    config.update.columns.exclude :item_list_items, :card_pages
    config.action_links.add :delete_and_regenerate_card_pages, :type => :record
  end


  def delete_and_regenerate_card_pages
    @list = ItemList.find params[:id]
    @list.regenerate_card_pages
    params[:associations] = 'card_pages'
    nested
  end
end
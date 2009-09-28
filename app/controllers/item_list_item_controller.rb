class ItemListItemController < ApplicationController

  active_scaffold :item_list_items do |config|
    config.columns.exclude :created_at, :updated_at
  end

end

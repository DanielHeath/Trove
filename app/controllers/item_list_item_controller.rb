class ItemListItemController < ApplicationController

  active_scaffold :item_list_items do |config|
    config.columns.exclude :created_at, :updated_at
    config.columns[:item].form_ui = :select
  end

end

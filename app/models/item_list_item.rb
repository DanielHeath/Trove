class ItemListItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :item_list
  
  validates_uniqueness_of :item_id, :scope => :item_list_id
  
  def name
    item.name
  end
end

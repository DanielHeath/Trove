class ItemList < ActiveRecord::Base
  has_many :item_list_items
  has_many :card_pages
  has_many :items, :through => :item_list_items
  
  def regenerate_card_pages
    card_pages.each {|c| c.destroy }
    filenames = items.collect {|i| i.card_image }
    until filenames.empty? do
      4.times do
        4.times do
          
        end
      end
      CardPage.create {:item_list => self}
    end
    
  end
end

class ItemList < ActiveRecord::Base
  has_many :item_list_items
  has_many :card_pages
  has_many :items, :through => :item_list_items
  validates_uniqueness_of :name
  
  def regenerate_card_pages
    card_pages.each {|c| c.destroy }
    i = 1
    n_by_m_arrays(items.collect {|item| item.card_image }).each do |page|
      CardPage.create({:item_list => self}).set_image(page, "card_page_#{i.to_s}.png")
      i += 1
    end
  end
  
  private
  
  def n_by_m_arrays(list, x=4, y=4)
    arrays = []
    until list.empty? do
      array = []
      x.times do
        next if list.empty?
        row = list.slice! 0..(y-1)
        
#        row = []
#        y.times do
#          next if list.empty?
#          row.push list.shift
#        end
        array << row
      end
      arrays << array
    end
    arrays
  end
  
  def split(list, number)
    [list[0..(number-1)], list[number-1, list.length]]
  end
end

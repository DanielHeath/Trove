require 'rubygems'
require 'RMagick'

class CardPage < ActiveRecord::Base
  belongs_to :item_list
  file_column :image
  
  def set_image(filename_grid)
    img = self.class.generate_image(filename_grid).to_blob
    img.write 'tmp/images/card_page.png'
  end
  
  def self.generate_image(filename_grid)
    result = Magick::ImageList.new()
    filename_grid.each do |row|
      result.push Magick::ImageList.new(*row).append(false)
    end
    result.append(true)
  end
  
end

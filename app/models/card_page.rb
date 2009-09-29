require 'rubygems'
require 'RMagick'

class FileColumnStringWrapper
  def initialize(str, filename, content_type = nil)
    @str, @filename, @content_type = str, filename, content_type
  end
  def read
    @str
  end
  def size
    @str.length
  end
  def original_filename
    @filename
  end
  def content_type
    @content_type
  end
end

class CardPage < ActiveRecord::Base
  belongs_to :item_list
  file_column :image
  
  def name
    File.basename image
  end
  
  def set_image(filename_grid, name='cardpage.png')
    img = self.class.generate_image(filename_grid)
    self.image = FileColumnStringWrapper.new(img.to_blob, name)
    save!
  end
  
  def self.generate_image(filename_grid)
    result = Magick::ImageList.new()
    filename_grid.each do |row|
      result.push Magick::ImageList.new(*row).append(false)
    end
    result.append(true)
  end
  
end

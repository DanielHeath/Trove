require 'rubygems'
require 'RMagick'
module CardGen
  # Subclass these to implement your own versions of these constants!
  class TextTemplate; end
  class TitleTextTemplate < TextTemplate;end
  class BonusTextTemplate < TextTemplate;end
  class PowerTextTemplate < TextTemplate;end

  class Template
    attr_accessor :title, :powers, :bonus, :minor_image, :main_image
    def page_width;1749;end
    def page_height;2478;end
    def dpi;300;end
    def dpc;112.1102;end
    def cards_across;4;end
    def cards_down;4;end
    def card_width;page_width / cards_across;end
    def card_height;page_height / cards_down;end
    def template_file;File.join(File.dirname(__FILE__), 'pics', 'template2.png');end
    def initialize(title, powers, bonus, slot, main_image)
      @main_image = main_image
      @minor_image = File.join(File.dirname(__FILE__), 'pics', 'weapon.png') # Later: Lookup correct image from slot!
      @title = TitleTextTemplate.new(self, title)
      @powers = PowerTextTemplate.new(self, powers)
      @bonus = BonusTextTemplate.new(self, bonus)
    end
    def main_pic_width;367;end
    def main_pic_height;271;end
    def main_pic_pos_x;35;end
    def main_pic_pos_y;73;end
    def minor_image_width;80;end
    def minor_image_height;80;end
    def minor_image_pos_x;30;end
    def minor_image_pos_y;card_height - minor_image_height - 30;end
    def output;'output.png';end;
  end

  class TextTemplate
    attr_accessor :template, :text
    def initialize(card_template, text)
      @template, @text = card_template, text
    end
    # Define a method named 'block' which returns the settings block for the draw object.
  end
  
  class TitleTextTemplate < TextTemplate
    def text_pos_x;0;end
    def text_pos_y;-35;end
    def text_width;template.card_width;end
    def text_height;30;end
    
    def block
      Proc.new {
        self.gravity = Magick::SouthGravity
        self.pointsize = 28
        self.stroke = 'transparent'
        self.fill = '#000000'
        self.font_weight = Magick::BoldWeight
      }
    end
  end # TitleTextTemplate
  
  class BonusTextTemplate < TextTemplate
    def text_pos_x;template.card_width - 110;end
    def text_pos_y;template.card_height - 65;end
    def text_width;74;end
    def text_height;35;end
    def block
      Proc.new {
        self.gravity = Magick::CenterGravity
        self.pointsize = 24
        self.stroke = 'transparent'
        self.fill = '#000000'
        self.font_weight = Magick::BoldWeight
      }
    end
  end # BonusTextTemplate
  
  class PowerTextTemplate < TextTemplate
    def text_pos_x;40;end
    def text_pos_y;400;end
    def text_width;360;end
    def text_height;180;end
    def block
      Proc.new {
        self.gravity = Magick::NorthWestGravity
        self.pointsize = 18
        self.stroke = 'transparent'
        self.fill = '#000000'
        self.font = '/Library/Fonts/Herculanum.ttf'
        #   self.font_weight = Magick::BoldWeight
      }
    end
  end # PowerTextTemplate

  class Generator
    include Magick
  
    def self.add_text(card, t)
      text = Magick::Draw.new
      text.annotate(card, t.text_width, t.text_height, t.text_pos_x, t.text_pos_y, t.text, &t.block)
    end
  
    def self.generate_card(t)
      card = Image.read(t.template_file).first
      card.resize_to_fill!(t.card_width, t.card_height)

      main_pic = Image.read(t.main_image).first
      main_pic.resize!(t.main_pic_width, t.main_pic_height)
      card.composite!(main_pic, t.main_pic_pos_x, t.main_pic_pos_y, OverCompositeOp)

      minor_pic = Image.read(t.minor_image).first
      minor_pic.resize!(t.minor_image_width,t.minor_image_height)
      card.composite!(minor_pic, t.minor_image_pos_x, t.minor_image_pos_y, OverCompositeOp)

      add_text card, t.title
      add_text card, t.powers
      add_text card, t.bonus
      
      card.density = t.dpc.to_s
      card.write(t.output)
    end
  
  end # class CardGen
end # module CardGen

a = CardGen::Template.new 'title', 'powers', '+1 AC', 'weapon', File.join(File.dirname(__FILE__), 'pics', 'sword_p1.png')
CardGen::Generator.generate_card a

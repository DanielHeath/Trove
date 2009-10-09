require 'rubygems'
require 'RMagick'
module CardGen

  class Template
    cattr_accessor :config
    self.config = File.open(File.join('config', 'cardgen.yml'), 'r') { |f| YAML::load(f) }
    
    attr_accessor :title, :powers, :bonus, :minor_image, :main_image, :output_file

    def page_width;self.class.config["page_width_px"];end
    def page_height;self.class.config["page_height_px"];end
    def dpi;self.class.config["page_dpi"];end
    def dpc;0.3737 * dpi;end    
    def cards_across;4;end
    def cards_down;4;end
    def card_width;page_width / cards_across;end
    def card_height;page_height / cards_down;end
    def template_file;File.join(@image_base, @template_file);end
    def initialize(title, powers, bonus, slot, main_image)
      @template_file = self.class.config["template"]
      @image_base = self.class.config["image_base"]
      @main_image = main_image
      @minor_image = File.join(@image_base, self.class.config["images"][slot] || "image_not_found")
      @title = TitleTextTemplate.new(self, title)
      @powers = PowerTextTemplate.new(self, powers)
      @bonus = BonusTextTemplate.new(self, bonus)
      @output_file = 'output.png'
    end
    def main_pic_width; 0.8393 * card_width;end
    def main_pic_height; 0.43745 * card_height;end
    def main_pic_pos_x;0.08 * card_width;end
    def main_pic_pos_y;0.1178 * card_height;end
    
    def minor_image_width; 0.183 * card_width;end
    def minor_image_height; 0.129 * card_height;end
    def minor_image_pos_x; 0.06861 * card_width;end
    def minor_image_pos_y; (0.9516 * card_height) - minor_image_height;end
    def generate_card;Generator.generate_card self;end
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
      Magick::Draw.new().annotate(card, t.text_width, t.text_height, t.text_pos_x, t.text_pos_y, t.text, &t.block) if t.text
    end
  
    def self.generate_image(t)
      puts 'Generating image...'
      card = Image.read(t.template_file).first
      card.resize_to_fill!(t.card_width, t.card_height)

      if t.main_image and File.exists? t.main_image 
        main_pic = Image.read(t.main_image).first
        main_pic.resize!(t.main_pic_width, t.main_pic_height)
        card.composite!(main_pic, t.main_pic_pos_x, t.main_pic_pos_y, OverCompositeOp)
      end
      
      if t.minor_image and File.exists? t.minor_image
        minor_pic = Image.read(t.minor_image).first
        minor_pic.resize!(t.minor_image_width,t.minor_image_height)
        card.composite!(minor_pic, t.minor_image_pos_x, t.minor_image_pos_y, OverCompositeOp)
      end
      
      add_text card, t.title
      add_text card, t.powers
      add_text card, t.bonus
      
      card.density = t.dpc.to_s
      puts 'Completed generating image.'
      card
    end
  
    def self.generate_card(t)
      generate_image(t).write(t.output_file)
    end
  
  end # class CardGen

end # module CardGen
